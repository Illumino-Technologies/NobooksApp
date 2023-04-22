part of '../../record_page.dart';

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
