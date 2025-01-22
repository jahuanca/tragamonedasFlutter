import 'package:get/get.dart';
import 'package:traga_monedas/src/point/di/add_point_binding.dart';
import 'package:traga_monedas/src/point/domain/entities/point_entity.dart';
import 'package:traga_monedas/src/point/ui/pages/add_point/add_point_page.dart';
import 'package:traga_monedas/src/utils/core/helpers.dart';
import 'package:traga_monedas/src/utils/ui/arguments.dart';
import 'package:traga_monedas/src/utils/ui/utils.dart';
import 'package:utils/utils.dart';

class DetailClientController extends GetxController {
  PointEntity? pointEntity;

  @override
  void onInit() {
    pointEntity = Get.setArguments(pointEntityArgument);
    super.onInit();
  }

  void goEdit() {
    Get.to(() => const AddPointPage(),
        binding: AddPointBinding(),
        arguments: {pointEntityArgument: pointEntity});
  }

  Future<void> goSendSMS() async {
    if (pointEntity?.phoneNumber == null) return;
    bool success = await sendSMS(numberPhone: pointEntity!.phoneNumber);
    if (!success) {
      _showError('No se pudo abrir mensajería.');
    }
  }

  void goCallPhone() async {
    if (pointEntity?.phoneNumber == null) return;
    bool success = await callPhone(numberPhone: pointEntity!.phoneNumber);
    if (!success) {
      _showError('No se abrir llamada.');
    }
  }

  void goSendEmail() async {
    if (pointEntity?.email == null) return;
    bool success = await sendEmail(
      email: pointEntity!.email,
      subject: emptyString,
      body: emptyString,
    );
    if (!success) {
      _showError('No se abrir gmail.');
    }
  }

  void goSendWhatsapp() async {
    if (pointEntity?.phoneNumber == null) return;
    bool success = await sendWhatsapp(
        numberPhone: pointEntity!.phoneNumber, message: emptyString);
    if (!success) {
      _showError('No se abrir Whatsapp.');
    }
  }

  void _showError(String message) {
    showSnackbarWidget(
        context: Get.overlayContext!,
        typeSnackbar: TypeSnackbar.error,
        message: message);
  }
}
