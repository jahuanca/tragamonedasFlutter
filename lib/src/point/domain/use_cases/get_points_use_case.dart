import 'package:traga_monedas/src/point/data/requests/point_request.dart';
import 'package:traga_monedas/src/point/domain/entities/point_entity.dart';
import 'package:traga_monedas/src/point/domain/repositories/point_repository.dart';
import 'package:utils/utils.dart';

class GetPointsUseCase {
  PointRepository repository;

  GetPointsUseCase({
    required this.repository,
  });

  Future<ResultType<List<PointEntity>, ErrorEntity>> execute({
    required PointRequest pointRequest,
  }) =>
      repository.getPoints(pointRequest: pointRequest);
}
