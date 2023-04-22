part of '../record_page.dart';

class _GradesTable extends StatefulWidget {
  const _GradesTable({Key? key}) : super(key: key);

  @override
  State<_GradesTable> createState() => _GradesTableState();
}

class _GradesTableState extends State<_GradesTable> {
  final List<Grade> grades = FakeGrades.allGrades;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...GradeTableColumn.values.map(
          (e) => IntrinsicWidth(
            child: TableColumn(
              column: e,
              index: e.index,
              grades: grades,
            ),
          ),
        ),
      ],
    );
  }
}
