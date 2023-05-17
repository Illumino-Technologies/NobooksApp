import 'package:flutter/material.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

abstract class FakeTimetable {
  static final List<TimetablePeriod> periods = List.generate(
    8,
    (index) {
      return TimetablePeriod(
        duration: 45,
        startTime: const TimeOfDay(hour: 8, minute: 0).copyAdd(
          Duration(minutes: 45 * index),
        ),
        periodName: index == 3 ? 'Break' : FakeSubjects.subjects[index].name,
        subject: FakeSubjects.subjects[index],
      );
    },
  );

  static final List<TimeTable> timetables =
      FakeClasses.classes.map<TimeTable>((e) => timeTable(e)).toList();

  static TimeTable timeTable(Class timetableClass) => TimeTable(
        periods: periods,
        timetableClass: timetableClass,
      );
}
