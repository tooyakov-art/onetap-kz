import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:onetap_kz/app/onetap_app.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('captures the five truthful App Store screens', (tester) async {
    await tester.pumpWidget(const OneTapApp());
    await tester.pumpAndSettle();
    await binding.takeScreenshot('01-suppliers');

    await _tapVisible(tester, find.byKey(const ValueKey('supplier-kws')));
    await binding.takeScreenshot('02-kws-catalog');

    final bushmills = find.byKey(
      const ValueKey('product-bushmills-original-05'),
    );
    await tester.ensureVisible(bushmills);
    await tester.tap(
      find.descendant(
        of: bushmills,
        matching: find.byKey(const ValueKey('quantity-add')),
      ),
    );
    await tester.pumpAndSettle();
    await binding.takeScreenshot('03-quantity');

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    await _tapVisible(
      tester,
      find.byKey(const ValueKey('supplier-coca-cola')),
    );
    final cola = find.byKey(const ValueKey('product-coke-05'));
    await tester.ensureVisible(cola);
    await tester.tap(
      find.descendant(
        of: cola,
        matching: find.byKey(const ValueKey('quantity-add')),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('catalog-open-cart')));
    await tester.pumpAndSettle();
    await binding.takeScreenshot('04-multi-supplier-cart');

    await _tapVisible(tester, find.textContaining('Сформировать заказ'));
    await binding.takeScreenshot('05-order-created');
  });
}

Future<void> _tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}
