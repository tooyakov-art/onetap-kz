import 'package:flutter/foundation.dart';

import '../../catalog/domain/catalog_models.dart';

class OrderLine {
  const OrderLine({required this.product, required this.quantity});

  final Product product;
  final int quantity;

  int get total => product.price * quantity;
}

class OrderDraft extends ChangeNotifier {
  final Map<String, int> _quantities = <String, int>{};

  int quantityFor(Product product) => _quantities[product.id] ?? 0;

  void add(Product product) {
    _quantities[product.id] = quantityFor(product) + 1;
    notifyListeners();
  }

  void remove(Product product) {
    final next = quantityFor(product) - 1;
    if (next <= 0) {
      _quantities.remove(product.id);
    } else {
      _quantities[product.id] = next;
    }
    notifyListeners();
  }

  List<OrderLine> lines(CatalogRepository catalog) => _quantities.entries
      .where((entry) => entry.value > 0)
      .map(
        (entry) => OrderLine(
          product: catalog.productById(entry.key),
          quantity: entry.value,
        ),
      )
      .toList(growable: false);

  int get itemCount =>
      _quantities.values.fold(0, (total, quantity) => total + quantity);

  int total(CatalogRepository catalog) =>
      lines(catalog).fold(0, (total, line) => total + line.total);

  Map<Supplier, List<OrderLine>> groupedLines(CatalogRepository catalog) {
    final result = <Supplier, List<OrderLine>>{};
    for (final line in lines(catalog)) {
      final supplier = catalog.supplierById(line.product.supplierId);
      result.putIfAbsent(supplier, () => <OrderLine>[]).add(line);
    }
    return result;
  }

  void clear() {
    _quantities.clear();
    notifyListeners();
  }
}
