import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traga_monedas/src/home/ui/pages/splash/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (_) => Scaffold(
        body: Container(),
      ),
    );
  }
}