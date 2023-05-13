part of '../record_page.dart';

class _RecordGraph extends ConsumerStatefulWidget {
  final Map<Class, List<Grade>> classGrades;

  const _RecordGraph({
    required this.classGrades,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_RecordGraph> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<_RecordGraph> {
  List<Color> gradientColors = [AppColors.blueVariant, AppColors.white];
  late String dropdownValue = termGrades.keys.first.name;

  late final List<Grade> currentClassGrades = widget.classGrades[
          ref.read(RecordsNotifier.provider).currentClass ??
              widget.classGrades.keys.first] ??
      [];

  final Map<TermPeriod, List<Grade>> termGrades = {};

  late final ValueNotifier<TermPeriod> termPeriodNotifier;

  //TODO: should rename
  void computeTermGrades(List<Grade> grades) {
    termGrades.clear();
    for (final Grade grade in grades) {
      if (termGrades.containsKey(grade.term)) {
        termGrades[grade.term]!.add(grade);
      } else {
        termGrades[grade.term] = [grade];
      }
    }
  }

  @override
  void initState() {
    super.initState();
    computeTermGrades(currentClassGrades);
    if (termGrades.isEmpty) return;
    termPeriodNotifier = ValueNotifier(termGrades.keys.first);
  }

  void onTermChanged(TermPeriod? term) {
    if (term == null) return;
    termPeriodNotifier.value = term;
  }

  void onClassChanged(Class class_) {
    setState(() {
      computeTermGrades(widget.classGrades[class_] ?? []);
    });
    if (termGrades.isEmpty) return;
    termPeriodNotifier.value = termGrades.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 761.w,
      decoration: const BoxDecoration(
        color: AppColors.backgroundGrey,
      ),
      child: termGrades.isEmpty
          ? const _NoRecordsWidget()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your Results',
                            style: TextStyles.headline6.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                          Row(
                            children: [
                              _ClassDropDown(onChanged: onClassChanged),
                              10.boxWidth,
                              _TermDropDown(
                                terms: termGrades.keys,
                                onTermChanged: onTermChanged,
                              ),
                            ],
                          )
                        ],
                      ),
                      20.boxHeight,
                      SizedBox(
                        height: 500,
                        child: ValueListenableBuilder<TermPeriod>(
                          valueListenable: termPeriodNotifier,
                          builder: (_, termPeriod, __) {
                            return LineChartWidget(
                              grades: termGrades[termPeriod]!,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

class _NoRecordsWidget extends StatelessWidget {
  const _NoRecordsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}