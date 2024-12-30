import 'dart:convert';

import 'package:traga_monedas/src/home/data/requests/add_income_request.dart';
import 'package:traga_monedas/src/home/domain/datastores/income_datastore.dart';
import 'package:traga_monedas/src/home/domain/entities/income_entity.dart';
import 'package:utils/utils.dart';

class IncomeDatastoreImplementation extends IncomeDatastore {
  @override
  Future<ResultType<List<String>, ErrorEntity>> getTypesIncome() async {
    AppHttpManager appHttpManager = AppHttpManager();
    AppResponseHttp appResponseHttp =
        await appHttpManager.get(url: '/income/types-income');
    if (appResponseHttp.isSuccessful) {
      return Success(
          data: (jsonDecode(appResponseHttp.body) as List)
              .map(
                (e) => e.toString(),
              )
              .toList());
    } else {
      return Error(
          error: ErrorEntity(
        statusCode: appResponseHttp.statusCode,
        title: 'Error al obtener los tipos de ingreso',
        errorMessage: appResponseHttp.body,
      ));
    }
  }

  @override
  Future<ResultType<IncomeEntity, ErrorEntity>> createIncome(
      AddIncomeRequest addIncomeRequest) async {
    AppHttpManager appHttpManager = AppHttpManager();
    AppResponseHttp appResponseHttp = await appHttpManager.post(
        url: '/income/create', body: addIncomeRequest);
    if (appResponseHttp.isSuccessful) {
      return Success(
          data: IncomeEntity.fromJson(jsonDecode(appResponseHttp.body)));
    } else {
      return Error(
          error: ErrorEntity(
        statusCode: appResponseHttp.statusCode,
        title: 'Error al crear ingreso',
        errorMessage: appResponseHttp.body,
      ));
    }
  }

  @override
  Future<ResultType<List<IncomeEntity>, ErrorEntity>> getIncomes({
    required int idPointMachine,
  }) async {
    AppHttpManager appHttpManager = AppHttpManager();
    AppResponseHttp appResponseHttp =
        await appHttpManager.get(url: '/income', query: {
      'idPointMachine': idPointMachine,
    });
    if (appResponseHttp.isSuccessful) {
      return Success(data: incomeEntityFromJson(appResponseHttp.body));
    } else {
      return Error(
          error: ErrorEntity(
        statusCode: appResponseHttp.statusCode,
        title: 'Error al obtener los ingreso',
        errorMessage: appResponseHttp.body,
      ));
    }
  }
}
