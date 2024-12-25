
import 'package:get/get.dart';
import 'package:traga_monedas/src/home/ui/pages/home_slot_machine_point/home_slot_machine_point_page.dart';
import 'package:traga_monedas/src/point/di/add_point_machine_binding.dart';
import 'package:traga_monedas/src/point/ui/pages/add_point_machine/add_point_machine_page.dart';

class ChooseSlotMachinePointController extends GetxController {

  void goAddPointMachine(){
    Get.to(() => const AddPointMachinePage(), binding: AddPointMachineBinding());
  }

  void goToContentSlotMachinePoint(){
    Get.to(()=> const HomeSlotMachinePointPage(),);
  }
}