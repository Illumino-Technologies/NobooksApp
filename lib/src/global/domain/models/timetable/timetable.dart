import 'package:flutter/material.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

part 'time_table_period.dart';

/// This class holds the timetable structure by periods and class
///
/// hence, each timetable has a class that it's meant for...
/// to access the periods on the timetable you can simply do:
///     ```timetables.where((element) => element.class == student.class);```
class TimeTable {
  final List<TimetablePeriod> periods;
  final Class timetableClass;

  const TimeTable({
    required this.periods,
    required this.timetableClass,
  });

  Map<String, dynamic> toMap() {
    return {
      'periods': periods.map((e) => e.toMap()).toList(),
      'class': timetableClass.toMap(),
    };
  }

  factory TimeTable.fromMap(Map<String, dynamic> map) {
    return TimeTable(
      periods: (map['periods'] as List?)
              ?.map((e) => TimetablePeriod.fromMap(e))
              .toList() ??
          [],
      timetableClass: Class.fromMap(map['class']),
    );
  }
}
