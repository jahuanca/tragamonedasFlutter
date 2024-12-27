
import 'package:traga_monedas/src/home/data/requests/add_income_request.dart';
import 'package:traga_monedas/src/home/domain/entities/income_entity.dart';
import 'package:traga_monedas/src/home/domain/repositories/income_repository.dart';
import 'package:utils/utils.dart';

class CreateIncomeUseCase {

  IncomeRepository repository;

  CreateIncomeUseCase({
    required this.repository,
  });

  Future<ResultType<IncomeEntity, ErrorEntity>> execute(AddIncomeRequest addIncomeRequest) async {
    return repository.createIncome(addIncomeRequest);
  }

}