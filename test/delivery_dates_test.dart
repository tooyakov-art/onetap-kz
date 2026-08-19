import 'package:flutter_test/flutter_test.dart';
import 'package:onetap_kz/core/delivery_dates.dart';

void main() {
  test('creates the next three delivery dates across a month boundary', () {
    final dates = upcomingDeliveryDates(DateTime(2026, 8, 31, 23, 45));

    expect(
      dates,
      [DateTime(2026, 9), DateTime(2026, 9, 2), DateTime(2026, 9, 3)],
    );
  });

  test('formats a delivery date in Russian', () {
    expect(formatDeliveryDate(DateTime(2026, 12, 5)), '5 декабря');
  });
}
