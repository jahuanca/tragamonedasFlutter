import 'package:get/get.dart';
import 'package:traga_monedas/src/home/di/login_binding.dart';
import 'package:traga_monedas/src/home/ui/pages/choose_slot_machine_point/choose_slot_machine_point_page.dart';
import 'package:traga_monedas/src/home/ui/pages/login/login_page.dart';
import 'package:traga_monedas/src/utils/core/data_local.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    (DataLocal.isLogged()) ? goChooseSlotMachine() : goLogin();
    super.onReady();
  }

  void goLogin() {
    Get.off(() => const LoginPage(), binding: LoginBinding());
  }

  void goChooseSlotMachine() {
    Get.to(() => const ChooseSlotMachinePage());
  }
}
