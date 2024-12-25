import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traga_monedas/src/home/ui/pages/splash/splash_page.dart';
import 'package:utils/utils.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Traga Perras',
      localizationsDelegates: localizationsDelegates,
      supportedLocales: const [
        Locale('es', 'ES'),
      ],
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}
