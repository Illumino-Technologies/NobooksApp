import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:nobook/src/features/records/domain/models/grade/grade.dart';
import 'package:nobook/src/features/records/domain/models/grade/term_period.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';

abstract class FakeGrades {
  static Grade mathGrade = Grade(
    id: 'math grade ${UniqueKey().toString()}',
    subject: FakeSubjects.maths,
    examScore: Random().nextBool() ? 59 : 49,
    caScores: Random().nextBool() ? [15, 15] : [20, 18],
    caPercent: 40,
    examPercent: 60,
    term: TermPeriod.first,
  );

  static Grade englishGrade = Grade(
    id: 'english grade ${UniqueKey().toString()}',
    subject: FakeSubjects.englishLanguage,
    examScore: Random().nextBool() ? 59 : 49,
    caScores: Random().nextBool() ? [15, 15] : [20, 18],
    caPercent: 40,
    examPercent: 60,
    term: TermPeriod.first,
  );

  static Grade chemistry = Grade(
    id: 'science grade ${UniqueKey().toString()}',
    subject: FakeSubjects.chemistry,
    examScore: Random().nextBool() ? 59 : 49,
    caScores: Random().nextBool() ? [15, 15] : [20, 18],
    caPercent: 40,
    examPercent: 60,
    term: TermPeriod.first,
  );

  static Grade biology = Grade(
    id: 'biology grade ${UniqueKey().toString()}',
    subject: FakeSubjects.biology,
    examScore: Random().nextBool() ? 59 : 49,
    caScores: Random().nextBool() ? [15, 15] : [20, 18],
    caPercent: 40,
    examPercent: 60,
    term: TermPeriod.first,
  );

  static Grade physics = Grade(
    id: 'physics grade ${UniqueKey().toString()}',
    subject: FakeSubjects.physics,
    examScore: Random().nextBool() ? 59 : 49,
    caScores: Random().nextBool() ? [15, 15] : [20, 18],
    caPercent: 40,
    examPercent: 60,
    term: TermPeriod.first,
  );

  static Grade economics = Grade(
    id: 'economics grade ${UniqueKey().toString()}',
    subject: FakeSubjects.economics,
    examScore: Random().nextBool() ? 59 : 49,
    caScores: Random().nextBool() ? [15, 15] : [20, 18],
    caPercent: 40,
    examPercent: 60,
    term: TermPeriod.first,
  );

  static Grade geography = Grade(
    id: 'geography grade ${UniqueKey().toString()}',
    subject: FakeSubjects.geography,
    examScore: Random().nextBool() ? 59 : 49,
    caScores: Random().nextBool() ? [15, 15] : [20, 18],
    caPercent: 40,
    examPercent: 60,
    term: TermPeriod.first,
  );

  static Grade furtherMaths = Grade(
    id: 'furtherMaths grade ${UniqueKey().toString()}',
    subject: FakeSubjects.furtherMaths,
    examScore: Random().nextBool() ? 59 : 49,
    caScores: Random().nextBool() ? [15, 15] : [20, 18],
    caPercent: 40,
    examPercent: 60,
    term: TermPeriod.first,
  );

  static Grade civicEducation = Grade(
    id: 'civicEducation grade ${UniqueKey().toString()}',
    subject: FakeSubjects.civicEducation,
    examScore: Random().nextBool() ? 59 : 49,
    caScores: Random().nextBool() ? [15, 15] : [20, 18],
    caPercent: 40,
    examPercent: 60,
    term: TermPeriod.first,
  );

  static Grade get bookKeeping => Grade(
        id: 'bookKeeping grade ${UniqueKey().toString()}',
        subject: FakeSubjects.bookKeeping,
        examScore: Random().nextBool() ? 59 : 49,
        caScores: Random().nextBool() ? [15, 15] : [20, 18],
        caPercent: 40,
        examPercent: 60,
        term: TermPeriod.first,
      );

  static final List<Grade> allGrades = [
    mathGrade,
    englishGrade,
    chemistry,
    biology,
    physics,
    economics,
    geography,
    furtherMaths,
    civicEducation,
    bookKeeping,
  ];

  static final Map<Class, List<Grade>> classGrades = {
    FakeClasses.ss2: allGrades,
    FakeClasses.ss3: allGrades,
  };
}
