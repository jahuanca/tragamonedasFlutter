
import 'package:get/get.dart';
import 'package:traga_monedas/src/home/data/datastores/auth_datastore_implementation.dart';
import 'package:traga_monedas/src/home/data/repositories/auth_repository_implementation.dart';
import 'package:traga_monedas/src/home/domain/datastores/auth_datastore.dart';
import 'package:traga_monedas/src/home/domain/repositories/auth_repository.dart';
import 'package:traga_monedas/src/home/domain/use_cases/login_use_case.dart';
import 'package:traga_monedas/src/home/ui/pages/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyReplace<AuthDatastore>(() => AuthDatastoreImplementation());
    Get.lazyReplace<AuthRepository>(() => AuthRepositoryImplementation(
      datastore: Get.find(),
    ));
    Get.lazyReplace<LoginUseCase>(() => LoginUseCase(repository: Get.find()));
    Get.lazyPut<LoginController>(() => LoginController(
      loginUseCase: Get.find(),
    ));
  }
}