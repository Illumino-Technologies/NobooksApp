import 'package:flutter/material.dart';
import 'package:nobook/src/features/features_barrel.dart';
import 'package:nobook/src/global/global_barrel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return NoBooksScaffold(
      onSearchFieldChanged: (value) {
        searchTextNotifier.value = value;
      },
      onNavItemChanged: onNavItemChanged,
      body: ValueListenableBuilder<NavItem>(
        valueListenable: currentPageNotifier,
        builder: (_, currentPage, __) {
          switch (currentPage) {
            case NavItem.dashboard:
              return const DashboardBoardPage();
            case NavItem.notes:
              return const NotePage();
            case NavItem.assignments:
              return const AssignmentBoard();
            case NavItem.testAndExams:
              return const TestandExamPage();
            case NavItem.records:
            case NavItem.arena:
            case NavItem.forum:
              return Container();
          }
        },
      ),
    );
  }

  void onNavItemChanged(NavItem item) {
    currentPageNotifier.value = item;
  }

  final ValueNotifier<String> searchTextNotifier = ValueNotifier<String>('');
  final ValueNotifier<NavItem> currentPageNotifier = ValueNotifier<NavItem>(
    NavItem.dashboard,
  );

  @override
  void dispose() {
    searchTextNotifier.dispose();
    currentPageNotifier.dispose();
    super.dispose();
  }
}
