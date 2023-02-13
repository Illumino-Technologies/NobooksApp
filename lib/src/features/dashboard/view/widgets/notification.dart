import 'package:flutter/material.dart';
import 'package:nobook/src/features/dashboard/models/notification.dart';
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
          itemCount: notification.length,
          itemBuilder: (context, index) => ListTile(
            tileColor: Colors.white.withOpacity(1),
            style: ListTileStyle.list,
            leading: Image.asset(Assets.book),
            title: Text(notification[index].title),
            subtitle: Text(notification[index].time),
          ),
        ),
      ),
    );
  }
}
