import 'dart:io';

import 'package:flutter/material.dart';
import 'package:traga_monedas/src/app.dart';
import 'package:traga_monedas/src/utils/core/colors.dart';
import 'package:traga_monedas/src/utils/core/config.dart';
import 'package:traga_monedas/src/utils/core/config_ui.dart';
import 'package:utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  UserPreferences prefs = UserPreferences();
  await prefs.initPrefs();

  loadConfig(
    DataConfig(
      primaryColor: primaryColorBase,
      borderRadius: borderRadiusBase,
      urlServer: serverUrl,
    )
  );
  HttpOverrides.global = MyHttpOverrides();
  runApp(const App());
}

class MyHttpOverrides extends HttpOverrides{

  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

