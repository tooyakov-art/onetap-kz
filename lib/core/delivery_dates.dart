const _russianMonths = <String>[
  'января',
  'февраля',
  'марта',
  'апреля',
  'мая',
  'июня',
  'июля',
  'августа',
  'сентября',
  'октября',
  'ноября',
  'декабря',
];

List<DateTime> upcomingDeliveryDates(DateTime now, {int count = 3}) {
  final today = DateTime(now.year, now.month, now.day);
  return List<DateTime>.generate(
    count,
    (index) => today.add(Duration(days: index + 1)),
    growable: false,
  );
}

String formatDeliveryDate(DateTime date) {
  return '${date.day} ${_russianMonths[date.month - 1]}';
}
