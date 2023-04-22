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
}

extension DoubleExtension on double {
  double? get nullIfZero => this == 0 ? null : this;
}

extension IntExtension on int {
  int? get nullIfZero => this == 0 ? null : this;
}
