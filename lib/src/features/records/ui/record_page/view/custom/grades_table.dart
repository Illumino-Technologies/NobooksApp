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
        IntrinsicWidth(
          child: Column(
            children: [
              Text('S/N'),
              const Divider(),
            ],
          ),
        )
      ],
    );
  }
}

enum GradeTableColumn {
  serialNumber('S/N'),
  subject('Subject'),
  code('Code'),
  ca('C/A'),
  exam('Exam'),
  total('Total'),
  grade('Grade'),
  ;

  final String text;

  const GradeTableColumn(this.text);

  String getGradeTextForValue(Grade grade, String serialNumber) {
    switch (this) {
      case GradeTableColumn.serialNumber:
        return serialNumber;
      case GradeTableColumn.subject:
        return grade.subject.name;
      case GradeTableColumn.code:
        return grade.subject.code;
      case GradeTableColumn.ca:
        return grade.ca?.toString() ?? '—';
      case GradeTableColumn.exam:
        return grade.exam?.toString() ?? '—';
      case GradeTableColumn.total:
        return grade.total?.toString() ?? '—';
      case GradeTableColumn.grade:
        return 'grade.grade';
    }
  }
}

class TableColumn extends StatelessWidget {
  final GradeTableColumn column;
  final String index;
  final List<Grade> grades;

  const TableColumn({
    Key? key,
    required this.column,
    required this.index,
    required this.grades,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
