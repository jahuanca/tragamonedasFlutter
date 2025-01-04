
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

  void goEdit(){
    Get.to(()=> const AddPointPage(), binding: AddPointBinding(), arguments: {
      pointEntityArgument: pointEntity
    });
  }

  void goSendSMS(){
    if(pointEntity?.phoneNumber == null) return;
    sendSMS(numberPhone: pointEntity!.phoneNumber);
  }

  void goCallPhone(){
    if(pointEntity?.phoneNumber == null) return;
    callPhone(numberPhone: pointEntity!.phoneNumber);
  }

  void goSendEmail(){
    if(pointEntity?.email == null) return;
    sendEmail(
      email: pointEntity!.email,
      subject: emptyString,
      body: emptyString,
    );
  }

  void goSendWhatsapp(){
    if(pointEntity?.phoneNumber == null) return;
    sendWhatsapp(
      numberPhone: pointEntity!.phoneNumber, 
      message: emptyString
    );
  }

}