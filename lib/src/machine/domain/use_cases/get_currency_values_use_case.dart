import 'package:traga_monedas/src/machine/domain/repositories/machine_repository.dart';
import 'package:utils/utils.dart';

class GetCurrencyValuesUseCase {
  MachineRepository repository;

  GetCurrencyValuesUseCase({
    required this.repository,
  });

  Future<ResultType<List<String>, ErrorEntity>> execute() =>
      repository.getCurrencyValues();
}
