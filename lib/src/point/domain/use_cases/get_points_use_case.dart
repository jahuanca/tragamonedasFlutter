import 'package:traga_monedas/src/point/domain/entities/point_entity.dart';
import 'package:traga_monedas/src/point/domain/repositories/point_repository.dart';
import 'package:utils/utils.dart';

class GetPointsUseCase {
  PointRepository repository;

  GetPointsUseCase({
    required this.repository,
  });

  Future<ResultType<List<PointEntity>, ErrorEntity>> execute() =>
      repository.getPoints();
}
