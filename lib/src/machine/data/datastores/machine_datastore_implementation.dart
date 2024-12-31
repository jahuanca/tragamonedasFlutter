import 'dart:convert';

import 'package:traga_monedas/src/machine/domain/datastores/machine_datastore.dart';
import 'package:traga_monedas/src/machine/domain/entities/machine_entity.dart';
import 'package:traga_monedas/src/point/data/requests/machine/machine_request.dart';
import 'package:utils/utils.dart';

class MachineDatastoreImplementation extends MachineDatastore {
  @override
  Future<ResultType<MachineEntity, ErrorEntity>> createMachine(
      {required MachineEntity machineEntity}) async {
    AppHttpManager appHttpManager = AppHttpManager();

    AppResponseHttp appResponseHttp =
        await appHttpManager.post(url: '/machine/create', body: machineEntity);
    if (appResponseHttp.isSuccessful) {
      return Success(
          data: MachineEntity.fromJson(jsonDecode(appResponseHttp.body)));
    } else {
      return Error(
          error: ErrorEntity(
              statusCode: appResponseHttp.statusCode,
              title: 'Error al crear la máquina',
              errorMessage: appResponseHttp.body));
    }
  }

  @override
  Future<ResultType<List<String>, ErrorEntity>> getCurrencyValues() async {
    AppHttpManager appHttpManager = AppHttpManager();

    AppResponseHttp appResponseHttp =
        await appHttpManager.get(url: '/machine/currency-values');
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
              title: 'Error al listar los tipos de moneda',
              errorMessage: appResponseHttp.body));
    }
  }

  @override
  Future<ResultType<List<MachineEntity>, ErrorEntity>> getMachines({
    required MachineRequest machineRequest,
  }) async {
    AppHttpManager appHttpManager = AppHttpManager();

    AppResponseHttp appResponseHttp = await appHttpManager.get(
        url: '/machine', query: machineRequest.toJson());
    if (appResponseHttp.isSuccessful) {
      return Success(data: machineEntityFromJson(appResponseHttp.body));
    } else {
      return Error(
          error: ErrorEntity(
              statusCode: appResponseHttp.statusCode,
              title: 'Error al listar las máquinas',
              errorMessage: appResponseHttp.body));
    }
  }
}
