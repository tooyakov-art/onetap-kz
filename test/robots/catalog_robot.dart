import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class CatalogRobot {
  CatalogRobot(this.tester);

  final WidgetTester tester;

  void expectHomeVisible() {
    expect(find.text('OneTap.kz'), findsOneWidget);
    expect(find.byKey(const ValueKey('supplier-kws')), findsOneWidget);
  }

  Future<void> openKwsCatalog() async {
    final supplier = find.byKey(const ValueKey('supplier-kws'));
    await tester.ensureVisible(supplier);
    await tester.pumpAndSettle();
    await tester.tap(supplier);
    await tester.pumpAndSettle();
  }

  void expectKwsPriceVisible() {
    expect(find.text('Прайс'), findsOneWidget);
    expect(find.text('Bushmills Original'), findsWidgets);
    expect(find.text('10 200 ₸'), findsOneWidget);
  }

  Future<void> addBushmillsOriginal() async {
    final product = find.byKey(const ValueKey('product-bushmills-original-05'));
    await tester.ensureVisible(product);
    await tester.pumpAndSettle();
    final addButton = find.descendant(
      of: product,
      matching: find.byKey(const ValueKey('quantity-add')),
    );
    await tester.tap(addButton);
    await tester.pumpAndSettle();
  }

  Future<void> openCart() async {
    await tester.tap(find.textContaining('1 шт. ·'));
    await tester.pumpAndSettle();
  }

  void expectCartReadyToSend() {
    expect(find.text('Общий заказ'), findsOneWidget);
    expect(find.textContaining('Сформировать заказ'), findsOneWidget);
    expect(find.textContaining('1 заявки'), findsOneWidget);
  }

  Future<void> createOrder() async {
    await tester.tap(find.textContaining('Сформировать заказ'));
    await tester.pumpAndSettle();
  }

  void expectOrderCreated() {
    expect(find.text('Заказ сформирован'), findsOneWidget);
    expect(find.text('Скопировать заказ'), findsOneWidget);
    expect(find.text('1 шт.'), findsOneWidget);
  }
}
