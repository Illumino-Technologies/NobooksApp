import 'package:flutter/material.dart';
import 'package:nobook/src/features/dashboard/dashboard_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: 700,
        // color: Colors.white,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: FakeDashboardData.notification.length,
          itemBuilder: (context, index) => ListTile(
            tileColor: Colors.white.withOpacity(1),
            style: ListTileStyle.list,
            leading: Image.asset(Assets.book),
            title: Text(FakeDashboardData.notification[index].title),
            subtitle: Text(FakeDashboardData.notification[index].time),
          ),
        ),
      ),
    );
  }
}
