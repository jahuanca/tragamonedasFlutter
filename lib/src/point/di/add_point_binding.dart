
import 'package:get/get.dart';
import 'package:traga_monedas/src/point/data/datastores/point_datastore_implementation.dart';
import 'package:traga_monedas/src/point/data/repositories/point_repository_implementation.dart';
import 'package:traga_monedas/src/point/domain/datastores/point_datastore.dart';
import 'package:traga_monedas/src/point/domain/repositories/point_repository.dart';
import 'package:traga_monedas/src/point/domain/use_cases/create_point_use_case.dart';
import 'package:traga_monedas/src/point/ui/pages/add_point/add_point_controlller.dart';

class AddPointBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyReplace<PointDatastore>(() => PointDatastoreImplementation());
    Get.lazyReplace<PointRepository>(() => PointRepositoryImplementation(
      datastore: Get.find(),
    ));
    Get.lazyReplace<CreatePointUseCase>(() => CreatePointUseCase(
      repository: Get.find(),
    ));
    Get.lazyPut<AddPointController>(() => AddPointController(
      createPointUseCase: Get.find(),
    ));
  }

}