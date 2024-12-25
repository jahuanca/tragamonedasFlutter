
import 'package:traga_monedas/src/machine/domain/entities/machine_entity.dart';
import 'package:traga_monedas/src/machine/domain/repositories/machine_repository.dart';
import 'package:utils/utils.dart';

class CreateMachineUseCase {

  MachineRepository repository;

  CreateMachineUseCase({
    required this.repository,
  });

  Future<ResultType<MachineEntity, ErrorEntity>> execute({
    required MachineEntity machine,
  }) async => await repository.createMachine(machineEntity: machine);

}