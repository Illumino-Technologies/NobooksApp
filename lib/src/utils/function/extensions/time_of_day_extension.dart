part of 'extensions.dart';

extension TimeOfDayExtension on TimeOfDay {
  //generate toMap method
  Map<String, dynamic> toMap() {
    return {
      'hour': hour,
      'minute': minute,
    };
  }

  TimeOfDay copyAdd(Duration duration) {
    final int totalMinutes = (duration.inMinutes + minute);
    final int hour = totalMinutes ~/ 60;
    final int minutes = totalMinutes % 60;

    return TimeOfDay(
      hour: hour,
      minute: minutes,
    );
  }
}
