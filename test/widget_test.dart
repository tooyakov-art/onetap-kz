import 'package:flutter_test/flutter_test.dart';
import 'package:onetap_kz/app/onetap_app.dart';

import 'robots/catalog_robot.dart';

void main() {
  testWidgets('should create a multi-supplier cart when products are added', (
    tester,
  ) async {
    final robot = CatalogRobot(tester);

    await tester.pumpWidget(const OneTapApp());
    await tester.pumpAndSettle();

    robot.expectHomeVisible();
    await robot.openKwsCatalog();
    robot.expectKwsPriceVisible();
    await robot.addBushmillsOriginal();
    await robot.openCart();
    robot.expectCartReadyToSend();
    await robot.createOrder();
    robot.expectOrderCreated();
  });

  testWidgets('should expose privacy and support inside the app', (
    tester,
  ) async {
    await tester.pumpWidget(const OneTapApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('О приложении'));
    await tester.pumpAndSettle();

    expect(find.text('Политика конфиденциальности'), findsOneWidget);
    expect(find.text('Поддержка'), findsOneWidget);
    expect(
      find.text('Заказы обрабатываются только на устройстве'),
      findsOneWidget,
    );
  });
}
