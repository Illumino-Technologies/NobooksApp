import 'package:nobook/src/utils/function/extensions/extensions.dart';

/// Term period generically represents the current term/mester of a school year
/// whether term/trimester, semester, or quarter/quadrimester.
/// It is generic because it's not always the same for all schools.
enum TermPeriod {
  first,
  second,
  third,
  fourth,
  ;

  String get ordinalText => '${name.toFirstUpperCase()} Term';

  int get number => index + 1;
}
