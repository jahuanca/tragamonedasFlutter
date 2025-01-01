
import 'package:get/get.dart';
import 'package:traga_monedas/src/home/di/login_binding.dart';
import 'package:traga_monedas/src/home/ui/pages/login/login_page.dart';
import 'package:traga_monedas/src/utils/core/data_local.dart';
import 'package:utils/utils.dart';

class SettingsController extends GetxController {

  Future<void> goExitApp() async {
    bool? result = await showDialogWidget(
      context: Get.overlayContext!, 
      message: '¿Esta seguro de cerrar sesión?');
    if(result.orFalse()){
      DataLocal.setLogged(false);
      Get.offAll(()=> const LoginPage(), binding: LoginBinding());
    }
  }

}