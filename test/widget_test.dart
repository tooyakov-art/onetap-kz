import 'package:flutter_test/flutter_test.dart';
import 'package:oneclick_kz/app/oneclick_app.dart';

import 'robots/catalog_robot.dart';

void main() {
  testWidgets('should create a multi-supplier cart when products are added', (
    tester,
  ) async {
    final robot = CatalogRobot(tester);

    await tester.pumpWidget(const OneClickApp());
    await tester.pumpAndSettle();

    robot.expectHomeVisible();
    await robot.openKwsCatalog();
    robot.expectKwsPriceVisible();
    await robot.addBushmillsOriginal();
    await robot.openCart();
    robot.expectCartReadyToSend();
  });
}
