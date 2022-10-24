import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/core/navigation/app_router.dart'; 

import 'package:nobook/ui/pages/dashboard/view/dashboard_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'No books',
      debugShowCheckedModeBanner: false,
      routerDelegate: AppRouter.router.routerDelegate,
      routeInformationParser: AppRouter.router.routeInformationParser,
      routeInformationProvider: AppRouter.router.routeInformationProvider,
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
      home: const AppStructure( backgroundColor:  Colors.red,
      rightBar: Text("rightbar"),
      leftBar: Text("leftbar"),
      body: Text("body"),
      appBar: Text("appbar"),),
    );
  }
}

