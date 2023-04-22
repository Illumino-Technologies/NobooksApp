part of 'custom_types.dart';

typedef Gradings = Map<DoubleRange, String>;

extension GradingsExtension on Gradings {
  String? getGrading(double value) {
    try {
      return entries.firstWhere((element) {
        return element.key.contains(value);
      }).value;
    } catch (e) {
      return null;
    }
  }
}
