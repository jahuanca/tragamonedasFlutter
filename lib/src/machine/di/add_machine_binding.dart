
import 'package:get/get.dart';
import 'package:traga_monedas/src/machine/data/datastores/machine_datastore_implementation.dart';
import 'package:traga_monedas/src/machine/data/repositories/machine_repository_implementation.dart';
import 'package:traga_monedas/src/machine/domain/datastores/machine_datastore.dart';
import 'package:traga_monedas/src/machine/domain/repositories/machine_repository.dart';
import 'package:traga_monedas/src/machine/domain/use_cases/create_machine_use_case.dart';
import 'package:traga_monedas/src/machine/domain/use_cases/get_currency_values_use_case.dart';
import 'package:traga_monedas/src/machine/ui/pages/add_machine/add_machine_controller.dart';

class AddMachineBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyReplace<MachineDatastore>(() => MachineDatastoreImplementation(),);
    Get.lazyReplace<MachineRepository>(() => MachineRepositoryImplementation(
      datastore: Get.find(),
    ),);

    Get.lazyReplace<GetCurrencyValuesUseCase>(() => GetCurrencyValuesUseCase(
      repository: Get.find(),
    ),);
    Get.lazyReplace<CreateMachineUseCase>(() => CreateMachineUseCase(
      repository: Get.find(),
    ),);

    Get.lazyReplace<AddMachineController>(() => AddMachineController(
      createMachineUseCase: Get.find(),
      getCurrencyValuesUseCase: Get.find(),
    ),);
  }
}