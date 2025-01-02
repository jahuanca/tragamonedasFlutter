
import 'package:get/get.dart';
import 'package:traga_monedas/src/point/di/add_point_binding.dart';
import 'package:traga_monedas/src/point/domain/entities/point_entity.dart';
import 'package:traga_monedas/src/point/ui/pages/add_point/add_point_page.dart';
import 'package:traga_monedas/src/utils/ui/arguments.dart';
import 'package:traga_monedas/src/utils/ui/utils.dart';


class DetailClientController extends GetxController {

  PointEntity? pointEntity;

  @override
  void onInit() {
    pointEntity = Get.setArguments(pointEntityArgument);
    super.onInit();
  }

  void goEdit(){
    Get.to(()=> const AddPointPage(), binding: AddPointBinding());
  }

}