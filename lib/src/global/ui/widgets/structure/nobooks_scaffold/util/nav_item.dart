part of '../nobooks_scaffold.dart';

enum NavItem {
  dashboard('Dashboard', VectorAssets.dashboardIcon),
  notes('Notes', VectorAssets.noteIcon),
  assignments('Assignments', VectorAssets.assignmentIcon),
  testAndExams('Tests & Exams', VectorAssets.examIcon),
  records('Records', VectorAssets.recordIcon),
  arena('Arena', VectorAssets.arenaIcon),
  forum('Forum', VectorAssets.forumIcon),
  ;

  final String text;
  final String vectorAsset;

  const NavItem(this.text, this.vectorAsset);
}
