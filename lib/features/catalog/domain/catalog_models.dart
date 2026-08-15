enum SupplierBrand { kws, cocaCola, pepsi }

enum CatalogSection { spirits, wine, softDrinks }

class Supplier {
  const Supplier({
    required this.id,
    required this.name,
    required this.caption,
    required this.category,
    required this.brand,
    required this.deliveryLabel,
  });

  final String id;
  final String name;
  final String caption;
  final String category;
  final SupplierBrand brand;
  final String deliveryLabel;
}

class Product {
  const Product({
    required this.id,
    required this.supplierId,
    required this.name,
    required this.subtitle,
    required this.brand,
    required this.section,
    required this.volume,
    required this.price,
    this.oldPrice,
  });

  final String id;
  final String supplierId;
  final String name;
  final String subtitle;
  final String brand;
  final CatalogSection section;
  final String volume;
  final int price;
  final int? oldPrice;

  bool get isPromotion => oldPrice != null && oldPrice! > price;
}

abstract interface class CatalogRepository {
  List<Supplier> get suppliers;

  List<Product> productsFor(String supplierId);

  Supplier supplierById(String id);

  Product productById(String id);
}
