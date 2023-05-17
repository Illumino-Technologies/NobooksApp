/// Term period generically represents the current term/mester of a school year
/// whether term/trimester, semester, or quarter/quadrimester.
/// It is generic because it's not always the same for all schools.
enum TermPeriod {
  first,
  second,
  third,
  fourth,
  ;

  int get number => index + 1;
}
