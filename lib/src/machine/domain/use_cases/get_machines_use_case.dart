import 'package:traga_monedas/src/machine/domain/entities/machine_entity.dart';
import 'package:traga_monedas/src/machine/domain/repositories/machine_repository.dart';
import 'package:utils/utils.dart';

class GetMachinesUseCase {
  MachineRepository repository;

  GetMachinesUseCase({
    required this.repository,
  });

  Future<ResultType<List<MachineEntity>, ErrorEntity>> execute() =>
      repository.getMachines();
}
