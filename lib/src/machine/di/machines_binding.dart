
import 'package:get/get.dart';
import 'package:traga_monedas/src/machine/data/datastores/machine_datastore_implementation.dart';
import 'package:traga_monedas/src/machine/data/repositories/machine_repository_implementation.dart';
import 'package:traga_monedas/src/machine/domain/datastores/machine_datastore.dart';
import 'package:traga_monedas/src/machine/domain/repositories/machine_repository.dart';
import 'package:traga_monedas/src/machine/domain/use_cases/get_machines_use_case.dart';
import 'package:traga_monedas/src/machine/ui/pages/machines/machines_controller.dart';

class MachinesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyReplace<MachineDatastore>(() => MachineDatastoreImplementation());
    Get.lazyReplace<MachineRepository>(() => MachineRepositoryImplementation(
      datastore: Get.find(),
    ));
    Get.lazyReplace<GetMachinesUseCase>(() => GetMachinesUseCase(
      repository: Get.find(),
    ));
    Get.lazyPut<MachinesController>(() => MachinesController(
      getMachinesUseCase: Get.find(),
    ));
  }
}