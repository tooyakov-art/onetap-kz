String formatMoney(int value) {
  final digits = value.toString();
  final output = StringBuffer();
  for (var index = 0; index < digits.length; index++) {
    if (index > 0 && (digits.length - index) % 3 == 0) {
      output.write(' ');
    }
    output.write(digits[index]);
  }
  return '$output ₸';
}
