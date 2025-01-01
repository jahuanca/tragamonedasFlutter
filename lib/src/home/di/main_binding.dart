import 'package:get/get.dart';
import 'package:traga_monedas/src/home/di/home_all_slot_binding.dart';
import 'package:traga_monedas/src/point_machine/di/machine_points_binding.dart';
import 'package:traga_monedas/src/machine/di/machines_binding.dart';
import 'package:traga_monedas/src/point/di/clients_binding.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    HomeAllSlotBinding().dependencies();
    MachinePointsBinding().dependencies();
    ClientsBinding().dependencies();
    MachinesBinding().dependencies();
  }

}