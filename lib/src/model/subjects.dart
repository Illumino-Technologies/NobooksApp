

import 'package:nobook/src/core/constants/assets.dart';

class TimeTable {
  final String subject;
  final String startTime;
  final String endTime;
  final String subjectLogo;

  TimeTable(this.subject, this.startTime, this.endTime,
      this.subjectLogo); // Hours:15:30:00 Format
}

final List<TimeTable> timeTable = [
  TimeTable('Maths', '8:00am', '10:00am', Assets.mt),
  TimeTable('Physics', '8:00am', '10:00am', Assets.mt),
  TimeTable('Chemistry', '8:00am', '10:00am', Assets.mt),
  TimeTable('Biology', '8:00am', '10:00am', Assets.mt),
  TimeTable('English', '8:00am', '10:00am', Assets.mt),
  TimeTable('Further Mathematics', '8:00am', '10:00am', Assets.mt),
];
