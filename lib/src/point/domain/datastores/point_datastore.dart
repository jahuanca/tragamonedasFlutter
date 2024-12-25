
import 'package:traga_monedas/src/point/domain/entities/point_entity.dart';
import 'package:traga_monedas/src/point/domain/entities/point_machine_entity.dart';
import 'package:utils/utils.dart';

abstract class PointDatastore {
  Future<ResultType<List<PointEntity>, ErrorEntity>> getPoints();

  Future<ResultType<PointEntity, ErrorEntity>> createPoint({
    required PointEntity pointEntity,
  });

  Future<ResultType<PointMachineEntity, ErrorEntity>> createPointMachine({
    required PointMachineEntity pointMachineEntity,
  });
}