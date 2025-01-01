import 'package:traga_monedas/src/home/data/requests/add_income_request.dart';
import 'package:traga_monedas/src/home/data/requests/incomes_request.dart';
import 'package:traga_monedas/src/home/domain/entities/income_entity.dart';
import 'package:utils/utils.dart';

abstract class IncomeRepository {

  Future<ResultType<List<String>, ErrorEntity>> getTypesIncome();
  Future<ResultType<List<IncomeEntity>, ErrorEntity>> getIncomes({
    required IncomesRequest pointMachineRequest,
  });
  Future<ResultType<IncomeEntity, ErrorEntity>> createIncome(AddIncomeRequest addIncomeRequest);
  

}