import 'package:traga_monedas/src/point/domain/entities/point_machine_entity.dart';
import 'package:traga_monedas/src/point/domain/repositories/point_repository.dart';
import 'package:utils/utils.dart';

class GetPointsMachineUseCase {
  PointRepository repository;

  GetPointsMachineUseCase({
    required this.repository,
  });

  Future<ResultType<List<PointMachineEntity>, ErrorEntity>> execute() =>
      repository.getPoinstMachine();
}
