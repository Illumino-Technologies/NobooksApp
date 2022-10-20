import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/core.dart';
import 'package:nobook/ui/pages/dashboard/view/dashboard_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        /*
        please read this before we progress

        i created a widget called AppStructure in core.dart that contains
         a body, appbar, rightbar, leftbar

        please when building each pages  use this as the background you 
        do not need to make a scaffold or any thing 
        just use this so that the whole program similar and you dont need
        to recreate that
      */
        primarySwatch: Colors.blue,
      ),
      home: const AppStructure(
        backgroundColor: Colors.red,
        rightBar: Text("rightbar"),
        leftBar: Text("leftbar"),
        body: DashboardPage(),
        appBar: Text("appbar"),
      ),
    );
  }
}
