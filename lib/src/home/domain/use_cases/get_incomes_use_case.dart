
import 'package:traga_monedas/src/home/domain/entities/income_entity.dart';
import 'package:traga_monedas/src/home/domain/repositories/income_repository.dart';
import 'package:utils/utils.dart';

class GetIncomesUseCase {

  IncomeRepository repository;

  GetIncomesUseCase({
    required this.repository,
  });

  Future<ResultType<List<IncomeEntity>, ErrorEntity>> execute({
    required int idPointMachine,
  }) async {
    return repository.getIncomes(idPointMachine: idPointMachine);
  }

}