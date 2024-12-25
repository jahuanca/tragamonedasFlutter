
import 'package:traga_monedas/src/point/domain/entities/point_entity.dart';
import 'package:traga_monedas/src/point/domain/repositories/point_repository.dart';
import 'package:utils/utils.dart';

class CreatePointUseCase {

  PointRepository repository;

  CreatePointUseCase({
    required this.repository,
  });

  Future<ResultType<PointEntity, ErrorEntity>> execute({
    required PointEntity pointEntity,
  }) => repository.createPoint(pointEntity: pointEntity);

}