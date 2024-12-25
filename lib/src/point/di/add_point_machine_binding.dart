import 'package:get/get.dart';
import 'package:traga_monedas/src/machine/data/datastores/machine_datastore_implementation.dart';
import 'package:traga_monedas/src/machine/data/repositories/machine_repository_implementation.dart';
import 'package:traga_monedas/src/machine/domain/datastores/machine_datastore.dart';
import 'package:traga_monedas/src/machine/domain/repositories/machine_repository.dart';
import 'package:traga_monedas/src/machine/domain/use_cases/get_machines_use_case.dart';
import 'package:traga_monedas/src/point/data/datastores/point_datastore_implementation.dart';
import 'package:traga_monedas/src/point/data/repositories/point_repository_implementation.dart';
import 'package:traga_monedas/src/point/domain/datastores/point_datastore.dart';
import 'package:traga_monedas/src/point/domain/repositories/point_repository.dart';
import 'package:traga_monedas/src/point/domain/use_cases/create_point_machine_use_case.dart';
import 'package:traga_monedas/src/point/domain/use_cases/get_points_use_case.dart';
import 'package:traga_monedas/src/point/ui/pages/add_point_machine/add_point_machine_controller.dart';

class AddPointMachineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyReplace<PointDatastore>(() => PointDatastoreImplementation());
    Get.lazyReplace<PointRepository>(() => PointRepositoryImplementation(
          datastore: Get.find(),
        ));
    Get.lazyReplace<MachineDatastore>(() => MachineDatastoreImplementation());
    Get.lazyReplace<MachineRepository>(() => MachineRepositoryImplementation(
          datastore: Get.find(),
        ));
    Get.lazyReplace<GetPointsUseCase>(() => GetPointsUseCase(
          repository: Get.find(),
        ));
    Get.lazyReplace<GetMachinesUseCase>(() => GetMachinesUseCase(
          repository: Get.find(),
        ));
    Get.lazyReplace<CreatePointMachineUseCase>(() => CreatePointMachineUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<AddPointMachineController>(() => AddPointMachineController(
          getPointsUseCase: Get.find(),
          getMachinesUseCase: Get.find(),
          createPointMachineUseCase: Get.find(),
        ));
  }
}
