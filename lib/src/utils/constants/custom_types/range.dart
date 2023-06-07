part of 'custom_types.dart';

typedef DoubleRange = ({double val1, double val2});

extension DoubleRangeExtension on DoubleRange {
  bool contains(double value) {
    final double maxValue = max(val1, val2);
    final double minValue = min(val1, val2);
    return value >= minValue && value <= maxValue;
  }

  List<double> toList() => [val1, val2];
}
