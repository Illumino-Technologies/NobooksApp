import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:nobook/src/features/features_barrel.dart';
import 'package:nobook/src/features/records/ui/record_page/view/record_page.dart';
import 'package:nobook/src/global/global_barrel.dart';

part 'app_route.dart';

part 'navigation_redirects.dart';

class AppRouter {
  static GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  static GlobalKey<NavigatorState> get shellRouteKey => _shellRouteKey;

  static GoRouter get router => _router;
}

final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellRouteKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  navigatorKey: _navigationKey,
  redirect: NavigationRedirects.baseRedirect,
  routes: [
    ShellRoute(
      navigatorKey: _shellRouteKey,
      builder: (context, state, child) =>
          HomeScreen(
            child: child,
          ),
      routes: [
        GoRoute(
          path: AppRoute.dashboard.path,
          name: AppRoute.dashboard.name,
          builder: (context, state) {
            return const DashBoardScreen();
          },
        ),
        GoRoute(
          path: AppRoute.note.path,
          name: AppRoute.note.name,
          builder: (context, state) {
            return const NoteScreen();
          },
          routes: [
            GoRoute(
              path: AppRoute.noteDetailPage.path,
              name: AppRoute.noteDetailPage.name,
              builder: (context, state) {
                return NoteDetailPage(
                  note: state.extra as Note,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: AppRoute.assignments.path,
          name: AppRoute.assignments.name,
          builder: (context, state) {
            return const AssignmentsPage();
          },
          routes: [
            GoRoute(
              path: AppRoute.assignment.path,
              name: AppRoute.assignment.name,
              builder: (context, state) {
                return AssignmentScreen(
                  assignment: state.extra as Assignment,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: AppRoute.assessmentListing.path,
          name: AppRoute.assessmentListing.name,
          builder: (context, state) {
            return const AssessmentsPage();
          },
          routes: [
            GoRoute(
              parentNavigatorKey: _navigationKey,
              path: AppRoute.assessmentDetail.path,
              name: AppRoute.assessmentDetail.name,
              builder: (context, state) {
                final (Assessment, AssessmentType) record = state
                    .extra as (Assessment, AssessmentType);
                return AssessmentDetailPage(
                  assessment: record.$0,
                  type: record.$1,

                );
              },
            ),
          ],
        ),
        GoRoute(
          path: AppRoute.record.path,
          name: AppRoute.record.name,
          builder: (context, state) {
            return const RecordPage();
          },
        ),
        
      ],
    ),
  ],
);
