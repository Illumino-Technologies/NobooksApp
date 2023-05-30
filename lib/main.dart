import 'package:flutter/material.dart';
import 'package:nobook/src/global/global_barrel.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageApi.initialize();
  NetworkApi();
  runApp(const NoBooksApp());
}
