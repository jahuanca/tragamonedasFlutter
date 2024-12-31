import 'package:traga_monedas/src/point/data/requests/point_request.dart';
import 'package:traga_monedas/src/point/domain/datastores/point_datastore.dart';
import 'package:traga_monedas/src/point/domain/entities/point_entity.dart';
import 'package:traga_monedas/src/point/domain/entities/point_machine_entity.dart';
import 'package:traga_monedas/src/point/domain/repositories/point_repository.dart';
import 'package:utils/utils.dart';

class PointRepositoryImplementation extends PointRepository {
  PointDatastore datastore;

  PointRepositoryImplementation({
    required this.datastore,
  });

  @override
  Future<ResultType<PointEntity, ErrorEntity>> createPoint(
          {required PointEntity pointEntity}) =>
      datastore.createPoint(pointEntity: pointEntity);

  @override
  Future<ResultType<List<PointEntity>, ErrorEntity>> getPoints({
    required PointRequest pointRequest,
  }) =>
      datastore.getPoints(pointRequest: pointRequest);

  @override
  Future<ResultType<PointMachineEntity, ErrorEntity>> createPointMachine({required PointMachineEntity pointMachineEntity}) {
    return datastore.createPointMachine(pointMachineEntity: pointMachineEntity);
  }
  
  @override
  Future<ResultType<List<PointMachineEntity>, ErrorEntity>> getPoinstMachine() {
    return datastore.getPoinstMachine();
  }
}
