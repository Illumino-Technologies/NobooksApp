part of '../record_page.dart';

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
