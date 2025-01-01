import 'package:get/get.dart';
import 'package:traga_monedas/src/home/di/login_binding.dart';
import 'package:traga_monedas/src/home/di/main_binding.dart';
import 'package:traga_monedas/src/home/ui/pages/login/login_page.dart';
import 'package:traga_monedas/src/home/ui/pages/main/main_page.dart';
import 'package:traga_monedas/src/utils/core/data_local.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    (DataLocal.isLogged()) ? goMain() : goLogin();
    super.onReady();
  }

  void goLogin() {
    Get.off(() => const LoginPage(), binding: LoginBinding());
  }

  void goMain() {
    Get.off(() => MainPage(), binding: MainBinding());
  }
}
