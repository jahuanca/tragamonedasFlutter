
import 'package:get/get.dart';
import 'package:traga_monedas/src/home/data/datastores/income_datastore_implementation.dart';
import 'package:traga_monedas/src/home/data/repositories/income_repository_implementation.dart';
import 'package:traga_monedas/src/home/domain/datastores/income_datastore.dart';
import 'package:traga_monedas/src/home/domain/repositories/income_repository.dart';
import 'package:traga_monedas/src/home/domain/use_cases/get_incomes_use_case.dart';
import 'package:traga_monedas/src/home/ui/pages/home_slot/home_slot_controller.dart';

class HomeSlotBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyReplace<IncomeDatastore>(() => IncomeDatastoreImplementation());
    Get.lazyReplace<IncomeRepository>(() => IncomeRepositoryImplementation(
      datastore: Get.find(),
    ));
    Get.lazyReplace<GetIncomesUseCase>(() => GetIncomesUseCase(repository: Get.find()));
    Get.lazyPut<HomeSlotController>(() => HomeSlotController(
      getIncomesUseCase: Get.find(),
    ));
  }

  
}