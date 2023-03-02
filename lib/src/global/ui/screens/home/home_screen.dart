import 'package:flutter/material.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:nobook/src/global/global_barrel.dart';

class HomeScreen extends StatefulWidget {
  final Widget child;

  const HomeScreen({Key? key, required this.child}) : super(key: key);

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
      body: widget.child,
    );
  }

  void onNavItemChanged(NavItem item) {
    context.goNamed(item.route.name);
  }

  final ValueNotifier<String> searchTextNotifier = ValueNotifier<String>('');

  @override
  void dispose() {
    searchTextNotifier.dispose();
    super.dispose();
  }
}
