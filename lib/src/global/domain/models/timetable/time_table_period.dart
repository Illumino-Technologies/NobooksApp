part of 'timetable.dart';

/// This holds the events on the time table...
/// eg:
///  TimetablePeriod(
///     subject: english,
///     duration: Duration(minutes: 40),
///     startTime: TimeOfDay(hour: 9, minute: 30),
///  ),
/// or
/// TimetablePeriod(
///     periodName: 'Break',
///     duration: Duration(minutes: 40),
///     startTime: TimeOfDay(hour: 11, minute: 30),
///  ),
///
/// notice how when it's a subject the periodName is null, and when it's not a
/// subject then we use the periodName to describe it.
/// That is the intended behavior
class TimetablePeriod {
  final Subject? subject;
  final String? periodName;
  final int duration;
  final TimeOfDay startTime;

  const TimetablePeriod({
    this.subject,
    this.periodName,
    required this.duration,
    required this.startTime,
  });

  TimeOfDay get endTime => startTime.copyAdd(Duration(minutes: duration));

  Map<String, dynamic> toMap() {
    return {
      'subject': subject?.toMap(),
      'periodName': periodName,
      'duration': duration,
      'startTime': startTime.toMap(),
    };
  }

  factory TimetablePeriod.fromMap(Map<String, dynamic> map) {
    return TimetablePeriod(
      subject: Subject.fromMap(map['subject']),
      periodName: map['periodName'] as String,
      duration: map['duration'] as int,
      startTime: UtilFunctions.timeOfDayFromMap(map['startTime']),
    );
  }
}
