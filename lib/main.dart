import 'package:base/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  await FlutterConfig.loadEnvVariables();
  await dotenv.load(fileName: ".env");

  var sharedPreferences = await SharedPreferences.getInstance();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(BaseApp(
    sharedPreferences: sharedPreferences,
  ));
}
