part of '../nobooks_scaffold.dart';

enum NavItem {
  dashboard('Dashboard', VectorAssets.dashboardIcon, AppRoute.dashboard),
  notes('Notes', VectorAssets.noteIcon, AppRoute.note),
  assignments('Assignments', VectorAssets.assignmentIcon, AppRoute.assignments),
  testAndExams(
      'Tests & Exams', VectorAssets.examIcon, AppRoute.assessmentListing),
  records('Records', VectorAssets.recordIcon, AppRoute.record),
  arena('Arena', VectorAssets.arenaIcon, AppRoute.arena),
  forum('Forum', VectorAssets.forumIcon, AppRoute.forum),
  ;

  final String text;
  final String vectorAsset;
  final AppRoute route;

  const NavItem(this.text, this.vectorAsset, this.route);
}
