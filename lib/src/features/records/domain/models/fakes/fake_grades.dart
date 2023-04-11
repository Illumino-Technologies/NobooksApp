import 'package:nobook/src/features/records/domain/models/grade/grade.dart';
import 'package:nobook/src/features/records/domain/models/grade/term_period.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';

abstract class FakeGrades {
  static const Grade mathGrade = Grade(
    id: 'math grade',
    subject: FakeSubjects.maths,
    examScore: 59,
    caScores: [20, 18],
    caPercent: 40,
    examPercent: 60,
    term: TermPeriod.first,
  );

  static const Grade englishGrade = Grade(
    id: 'english grade',
    subject: FakeSubjects.englishLanguage,
    examScore: 59,
    caScores: [20, 18],
    caPercent: 40,
    examPercent: 60,
    term: TermPeriod.first,
  );

  static const Grade chemistry = Grade(
    id: 'science grade',
    subject: FakeSubjects.chemistry,
    examScore: 59,
    caScores: [20, 18],
    caPercent: 40,
    examPercent: 60,
    term: TermPeriod.first,
  );

  static const Grade biology = Grade(
    id: 'biology grade',
    subject: FakeSubjects.biology,
    examScore: 59,
    caScores: [20, 18],
    caPercent: 40,
    examPercent: 60,
    term: TermPeriod.first,
  );

  static const Grade physics = Grade(
    id: 'physics grade',
    subject: FakeSubjects.physics,
    examScore: 59,
    caScores: [20, 18],
    caPercent: 40,
    examPercent: 60,
    term: TermPeriod.first,
  );

  static const Grade economics = Grade(
    id: 'economics grade',
    subject: FakeSubjects.economics,
    examScore: 59,
    caScores: [20, 18],
    caPercent: 40,
    examPercent: 60,
    term: TermPeriod.first,
  );

  static const Grade geography = Grade(
    id: 'geography grade',
    subject: FakeSubjects.geography,
    examScore: 59,
    caScores: [20, 18],
    caPercent: 40,
    examPercent: 60,
    term: TermPeriod.first,
  );

  static const Grade furtherMaths = Grade(
    id: 'furtherMaths grade',
    subject: FakeSubjects.furtherMaths,
    examScore: 59,
    caScores: [20, 18],
    caPercent: 40,
    examPercent: 60,
    term: TermPeriod.first,
  );

  static const Grade civicEducation = Grade(
    id: 'civicEducation grade',
    subject: FakeSubjects.civicEducation,
    examScore: 59,
    caScores: [20, 18],
    caPercent: 40,
    examPercent: 60,
    term: TermPeriod.first,
  );

  static const Grade bookKeeping = Grade(
    id: 'bookKeeping grade',
    subject: FakeSubjects.bookKeeping,
    examScore: 59,
    caScores: [20, 18],
    caPercent: 40,
    examPercent: 60,
    term: TermPeriod.first,
  );

  static const List<Grade> allGrades = [
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
}
