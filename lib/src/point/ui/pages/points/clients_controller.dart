import 'package:get/get.dart';
import 'package:traga_monedas/src/point/data/requests/point_request.dart';
import 'package:traga_monedas/src/point/di/add_point_binding.dart';
import 'package:traga_monedas/src/point/domain/entities/point_entity.dart';
import 'package:traga_monedas/src/point/domain/use_cases/get_points_use_case.dart';
import 'package:traga_monedas/src/point/ui/pages/add_point/add_point_page.dart';
import 'package:traga_monedas/src/point/ui/pages/detail_client/detail_client_page.dart';
import 'package:traga_monedas/src/utils/ui/arguments.dart';
import 'package:traga_monedas/src/utils/ui/ids_get.dart';
import 'package:utils/utils.dart';

class ClientsController extends GetxController {
  GetPointsUseCase getPointsUseCase;
  List<PointEntity> points = [];
  bool validando = false;

  ClientsController({
    required this.getPointsUseCase,
  });

  @override
  void onReady() {
    getPoints();
    super.onReady();
  }

  Future<void> getPoints() async {
    validando = true;
    update([validandoIdGet]);
    ResultType<List<PointEntity>, ErrorEntity> resultType =
        await getPointsUseCase.execute(
            pointRequest: PointRequest());
    if (resultType is Success) {
      List<PointEntity> results = resultType.data as List<PointEntity>;
      points = results;
    } else {

    }
    validando = false;
    update([pointsIdGet, validandoIdGet]);
  }

  void goDetail(PointEntity pointEntity){
    Get.to(()=> const DetailClientPage(), arguments: {
      pointEntityArgument: pointEntity,
    });
  }

  void goAdd() async {
    PointEntity? result = await Get.to(()=> const AddPointPage(), binding:  AddPointBinding());
    if(result != null){
      getPoints();
    }
  }
}
