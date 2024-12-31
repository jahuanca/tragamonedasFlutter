
import 'package:traga_monedas/src/point/data/requests/point_request.dart';
import 'package:traga_monedas/src/point/domain/entities/point_entity.dart';
import 'package:traga_monedas/src/point/domain/entities/point_machine_entity.dart';
import 'package:utils/utils.dart';

abstract class PointRepository {
  Future<ResultType<List<PointEntity>, ErrorEntity>> getPoints({
    required PointRequest pointRequest,
  });
  
  Future<ResultType<List<PointMachineEntity>, ErrorEntity>> getPoinstMachine();

  Future<ResultType<PointEntity, ErrorEntity>> createPoint({
    required PointEntity pointEntity,
  });

  Future<ResultType<PointMachineEntity, ErrorEntity>> createPointMachine({
    required PointMachineEntity pointMachineEntity,
  });
}