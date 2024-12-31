
import 'package:traga_monedas/src/home/data/requests/add_income_request.dart';
import 'package:traga_monedas/src/home/data/requests/point_machine_request.dart';
import 'package:traga_monedas/src/home/domain/entities/income_entity.dart';
import 'package:utils/utils.dart';

abstract class IncomeDatastore {
  Future<ResultType<List<String>, ErrorEntity>> getTypesIncome();
  Future<ResultType<List<IncomeEntity>, ErrorEntity>> getIncomes({
    required PointMachineRequest pointMachineRequest,
  });
  Future<ResultType<IncomeEntity, ErrorEntity>> createIncome(AddIncomeRequest addIncomeRequest);

}