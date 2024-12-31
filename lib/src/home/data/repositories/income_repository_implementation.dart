import 'package:traga_monedas/src/home/data/requests/add_income_request.dart';
import 'package:traga_monedas/src/home/data/requests/point_machine_request.dart';
import 'package:traga_monedas/src/home/domain/datastores/income_datastore.dart';
import 'package:traga_monedas/src/home/domain/entities/income_entity.dart';
import 'package:traga_monedas/src/home/domain/repositories/income_repository.dart';
import 'package:utils/utils.dart';

class IncomeRepositoryImplementation extends IncomeRepository {
  IncomeDatastore datastore;

  IncomeRepositoryImplementation({
    required this.datastore,
  });

  @override
  Future<ResultType<List<String>, ErrorEntity>> getTypesIncome() {
    return datastore.getTypesIncome();
  }

  @override
  Future<ResultType<IncomeEntity, ErrorEntity>> createIncome(
      AddIncomeRequest addIncomeRequest) {
    return datastore.createIncome(addIncomeRequest);
  }

  @override
  Future<ResultType<List<IncomeEntity>, ErrorEntity>> getIncomes({
    required PointMachineRequest pointMachineRequest,
  }) {
    return datastore.getIncomes(pointMachineRequest: pointMachineRequest);
  }
}
