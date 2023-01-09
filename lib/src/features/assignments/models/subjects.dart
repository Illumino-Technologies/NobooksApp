import 'package:nobook/src/core/constants/assets.dart';

class TimeTable {
  final String subject;
  final String subjectLogo;

  TimeTable(this.subject, this.subjectLogo); // Hours:15:30:00 Format
}

final List<TimeTable> timeTable = [
  TimeTable('Maths', Assets.mt),
  TimeTable('Physics', Assets.mt),
  TimeTable('Chemistry', Assets.mt),
  TimeTable('Biology', Assets.mt),
  TimeTable('English', Assets.mt),
  TimeTable('Further Mathematics',  Assets.mt),
  TimeTable('Maths',  Assets.mt),
  TimeTable('Physics', Assets.mt),
  TimeTable('Chemistry', Assets.mt),
  TimeTable('Biology', Assets.mt),
  TimeTable('English', Assets.mt),
  TimeTable('Further Mathematics', Assets.mt),
];
