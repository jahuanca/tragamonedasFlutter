
import 'package:get/get.dart';
import 'package:traga_monedas/src/home/ui/pages/choose_slot_machine_point/choose_slot_machine_point_controller.dart';
import 'package:traga_monedas/src/point/data/datastores/point_datastore_implementation.dart';
import 'package:traga_monedas/src/point/data/repositories/point_repository_implementation.dart';
import 'package:traga_monedas/src/point/domain/datastores/point_datastore.dart';
import 'package:traga_monedas/src/point/domain/repositories/point_repository.dart';
import 'package:traga_monedas/src/point/domain/use_cases/get_points_machine_use_case.dart';

class ChooseSlotMachinePointBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyReplace<PointDatastore>(() => PointDatastoreImplementation());
    Get.lazyReplace<PointRepository>(() => PointRepositoryImplementation(
      datastore: Get.find(),
    ));
    Get.lazyReplace<GetPointsMachineUseCase>(() => GetPointsMachineUseCase(
      repository: Get.find(),
    ));
    Get.lazyPut<ChooseSlotMachinePointController>(() => ChooseSlotMachinePointController(
      getPointsMachineUseCase: Get.find(),
    ));
  }
}