import 'package:get/get.dart';
import 'package:traga_monedas/src/point/data/datastores/point_datastore_implementation.dart';
import 'package:traga_monedas/src/point/data/repositories/point_repository_implementation.dart';
import 'package:traga_monedas/src/point/domain/datastores/point_datastore.dart';
import 'package:traga_monedas/src/point/domain/repositories/point_repository.dart';
import 'package:traga_monedas/src/point/domain/use_cases/get_points_use_case.dart';
import 'package:traga_monedas/src/point/ui/pages/points/clients_controller.dart';

class ClientsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyReplace<PointDatastore>(() => PointDatastoreImplementation());
    Get.lazyReplace<PointRepository>(() => PointRepositoryImplementation(
      datastore: Get.find(),
    ));
    Get.lazyReplace<GetPointsUseCase>(() => GetPointsUseCase(
      repository: Get.find(),
    ));
    Get.lazyPut<ClientsController>(() => ClientsController(
      getPointsUseCase: Get.find(),
    ));
  }
}
