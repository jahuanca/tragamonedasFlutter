import 'package:traga_monedas/src/machine/domain/entities/machine_entity.dart';
import 'package:utils/utils.dart';

abstract class MachineDatastore {
  Future<ResultType<List<MachineEntity>, ErrorEntity>> getMachines();

  Future<ResultType<MachineEntity, ErrorEntity>> createMachine({
    required MachineEntity machineEntity,
  });

  Future<ResultType<List<String>, ErrorEntity>> getCurrencyValues();
}
