part of 'extensions.dart';

extension NumExtension on num {
  ///returns value * (percentage/100)
  double percent(num percentage) => (this * (percentage / 100)).toDouble();

  SizedBox get boxHeight => SizedBox(
        height: h.toDouble(),
        width: 0,
      );

  SizedBox get boxWidth => SizedBox(
        height: 0,
        width: w.toDouble(),
      );

  String get pluralValue {
    if (this == 1) return '';
    return 's';
  }

  String toOrdinal() {
    final int number = toInt();
    final int mod = number % 100;

    if (mod >= 11 && mod <= 13) {
      return '${number}th';
    }

    switch (number % 10) {
      case 1:
        return '${number}st';
      case 2:
        return '${number}nd';
      case 3:
        return '${number}rd';
      default:
        return '${number}th';
    }
  }
}

extension DoubleExtension on double {
  double? get nullIfZero => this == 0 ? null : this;
}

extension IntExtension on int {
  int? get nullIfZero => this == 0 ? null : this;
}
