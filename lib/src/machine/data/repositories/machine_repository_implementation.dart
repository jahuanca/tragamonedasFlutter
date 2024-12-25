import 'package:traga_monedas/src/machine/domain/datastores/machine_datastore.dart';
import 'package:traga_monedas/src/machine/domain/entities/machine_entity.dart';
import 'package:traga_monedas/src/machine/domain/repositories/machine_repository.dart';
import 'package:utils/utils.dart';

class MachineRepositoryImplementation extends MachineRepository {
  MachineDatastore datastore;

  MachineRepositoryImplementation({
    required this.datastore,
  });

  @override
  Future<ResultType<MachineEntity, ErrorEntity>> createMachine(
          {required MachineEntity machineEntity}) =>
      datastore.createMachine(machineEntity: machineEntity);

  @override
  Future<ResultType<List<String>, ErrorEntity>> getCurrencyValues() =>
      datastore.getCurrencyValues();

  @override
  Future<ResultType<List<MachineEntity>, ErrorEntity>> getMachines() =>
      datastore.getMachines();
}
