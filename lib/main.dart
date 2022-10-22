import 'package:flutter/material.dart';
import 'package:nobook/src/core/navigation/app_router.dart'; 


void main() {
  runApp(const MyApp());
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
 
      ),
      // home: const AppStructure( backgroundColor:  Colors.red,
      // rightBar: Text("rightbar"),
      // leftBar: Text("leftbar"),
      // body: Text("body"),
      // appBar: Text("appbar"),),
    );
  }
}
