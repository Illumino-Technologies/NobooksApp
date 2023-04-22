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

  String getGradeTextForValue(
    Grade grade,
    String serialNumber,
    Student student,
  ) {
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
        return grade.gradingFor(student.studentClass) ?? '—';
    }
  }
}

class TableColumn extends ConsumerWidget {
  final GradeTableColumn column;
  final int index;
  final List<Grade> grades;

  const TableColumn({
    Key? key,
    required this.column,
    required this.index,
    required this.grades,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: column == GradeTableColumn.subject
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        const Divider(
          color: AppColors.blue500,
          height: 1,
          thickness: 1,
        ),
        8.boxHeight,
        Text(
          column.text,
          style: TextStyles.headline1.copyWith(
            height: 1.714,
            color: AppColors.neutral00,
            fontSize: 14,
          ),
        ),
        8.boxHeight,
        const Divider(
          color: AppColors.blue500,
          height: 1,
          thickness: 1,
        ),
        ...grades.map(
          (e) => Padding(
            padding: EdgeInsets.only(top: 16.h, left: 30.w, right: 30.w),
            child: Text(
              column.getGradeTextForValue(
                e,
                (grades.indexOf(e) + 1).toString(),
                ref.read(StudentNotifier.provider)!,
              ),
              textAlign: column == GradeTableColumn.subject
                  ? TextAlign.start
                  : TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
