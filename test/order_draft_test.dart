import 'package:flutter_test/flutter_test.dart';
import 'package:oneclick_kz/features/catalog/data/demo_catalog_repository.dart';
import 'package:oneclick_kz/features/order/application/order_draft.dart';

void main() {
  const catalog = DemoCatalogRepository();

  test(
    'should split lines by supplier when products come from different catalogs',
    () {
      final draft = OrderDraft();
      addTearDown(draft.dispose);

      draft.add(catalog.productById('bushmills-original-10'));
      draft.add(catalog.productById('coke-10'));
      draft.add(catalog.productById('coke-10'));

      expect(draft.itemCount, 3);
      expect(draft.groupedLines(catalog).length, 2);
      expect(draft.total(catalog), 19100);
    },
  );
}
