import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';

abstract class FakeSubjects {
  static const List<Subject> subjects = [
    maths,
    englishLanguage,
    chemistry,
    biology,
    physics,
    furtherMaths,
    geography,
    economics,
    civicEducation,
    bookKeeping,
  ];

  static const Subject biology = Subject(
    code: 'BI',
    name: 'Biology',
    color: AppColors.subjectGreenVariant,
  );

  static const Subject maths = Subject(
    code: 'MT',
    name: 'Maths',
    color: AppColors.subjectWine,
  );

  static const Subject bookKeeping = Subject(
    code: 'BK',
    name: 'Book Keeping',
    color: AppColors.subjectPink,
  );

  static const Subject chemistry = Subject(
    code: 'CH',
    name: 'Chemistry',
    color: AppColors.subjectDarkOrange,
  );

  static const Subject civicEducation = Subject(
    code: 'CV',
    name: 'Civic Education',
    color: AppColors.subjectLightBlue,
  );

  static const Subject economics = Subject(
    code: 'EC',
    name: 'Economics',
    color: AppColors.subjectLightBlueVariant,
  );

  static const Subject geography = Subject(
    code: 'GE',
    name: 'Geography',
    color: AppColors.subjectPinkVariant,
  );

  static const Subject furtherMaths = Subject(
    code: 'FM',
    name: 'Further Maths',
    color: AppColors.subjectOrange,
  );

  static const Subject physics = Subject(
    code: 'PH',
    name: 'Physics',
    color: AppColors.subjectLightGreen,
  );

  static const Subject englishLanguage = Subject(
    code: 'EN',
    name: 'English Language',
    color: AppColors.subjectBlue,
  );
}
