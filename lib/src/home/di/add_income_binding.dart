
import 'package:get/get.dart';
import 'package:traga_monedas/src/home/data/datastores/income_datastore_implementation.dart';
import 'package:traga_monedas/src/home/data/repositories/income_repository_implementation.dart';
import 'package:traga_monedas/src/home/domain/datastores/income_datastore.dart';
import 'package:traga_monedas/src/home/domain/repositories/income_repository.dart';
import 'package:traga_monedas/src/home/domain/use_cases/create_income_use_case.dart';
import 'package:traga_monedas/src/home/domain/use_cases/get_types_income_use_case.dart';
import 'package:traga_monedas/src/home/ui/pages/add_income/add_income_controller.dart';

class AddIncomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyReplace<IncomeDatastore>(() => IncomeDatastoreImplementation());
    Get.lazyReplace<IncomeRepository>(() => IncomeRepositoryImplementation(
      datastore: Get.find(),
    ));
    Get.lazyReplace<GetTypesIncomeUseCase>(() => GetTypesIncomeUseCase(repository: Get.find()));
    Get.lazyReplace<CreateIncomeUseCase>(() => CreateIncomeUseCase(repository: Get.find()));
    Get.lazyPut<AddIncomeController>(() => AddIncomeController(
      getTypesIncomeUseCase: Get.find(),
      createIncomeUseCase: Get.find(),
    ));
  }
}