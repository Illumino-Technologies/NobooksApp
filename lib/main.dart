import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nobook/src/global/global_barrel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageApi.initialize();
  NetworkApi();
  TokenManager.storeToken('balablu blu blu');

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const NoBooksApp());
}
