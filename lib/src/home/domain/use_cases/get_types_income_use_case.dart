
import 'package:traga_monedas/src/home/domain/repositories/income_repository.dart';
import 'package:utils/utils.dart';

class GetTypesIncomeUseCase {

  IncomeRepository repository;

  GetTypesIncomeUseCase({
    required this.repository,
  });

  Future<ResultType<List<String>, ErrorEntity>> execute(){
    return repository.getTypesIncome();
  }

}