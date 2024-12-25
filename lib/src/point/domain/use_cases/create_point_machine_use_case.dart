import 'package:traga_monedas/src/point/domain/entities/point_machine_entity.dart';
import 'package:traga_monedas/src/point/domain/repositories/point_repository.dart';
import 'package:utils/utils.dart';

class CreatePointMachineUseCase {
  PointRepository repository;

  CreatePointMachineUseCase({
    required this.repository,
  });

  Future<ResultType<PointMachineEntity, ErrorEntity>> execute({
    required PointMachineEntity pointMachineEntity,
  }) {
    return repository.createPointMachine(
        pointMachineEntity: pointMachineEntity);
  }
}
