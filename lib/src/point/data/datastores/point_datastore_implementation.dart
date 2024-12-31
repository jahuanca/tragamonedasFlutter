import 'dart:convert';

import 'package:traga_monedas/src/point/data/requests/point_request.dart';
import 'package:traga_monedas/src/point/domain/datastores/point_datastore.dart';
import 'package:traga_monedas/src/point/domain/entities/point_entity.dart';
import 'package:traga_monedas/src/point/domain/entities/point_machine_entity.dart';
import 'package:utils/utils.dart';

class PointDatastoreImplementation extends PointDatastore {
  @override
  Future<ResultType<PointEntity, ErrorEntity>> createPoint(
      {required PointEntity pointEntity}) async {
    AppHttpManager appHttpManager = AppHttpManager();
    AppResponseHttp appResponseHttp =
        await appHttpManager.post(url: '/point/create', body: pointEntity);
    if (appResponseHttp.isSuccessful) {
      return Success(
          data: PointEntity.fromJson(jsonDecode(appResponseHttp.body)));
    } else {
      return Error(
          error: ErrorEntity(
              statusCode: appResponseHttp.statusCode,
              title: 'Error al crear el punto',
              errorMessage: appResponseHttp.body));
    }
  }

  @override
  Future<ResultType<List<PointEntity>, ErrorEntity>> getPoints({
    required PointRequest pointRequest,
  }) async {
    AppHttpManager appHttpManager = AppHttpManager();
    AppResponseHttp appResponseHttp = await appHttpManager.get(url: '/point', query: pointRequest.toJson());
    if (appResponseHttp.isSuccessful) {
      return Success(data: pointEntityFromJsonList(appResponseHttp.body));
    } else {
      return Error(
          error: ErrorEntity(
              statusCode: appResponseHttp.statusCode,
              title: 'Error al listar los puntos',
              errorMessage: appResponseHttp.body));
    }
  }

  @override
  Future<ResultType<PointMachineEntity, ErrorEntity>> createPointMachine(
      {required PointMachineEntity pointMachineEntity}) async {
    AppHttpManager appHttpManager = AppHttpManager();
    AppResponseHttp appResponseHttp = await appHttpManager.post(
        url: '/point-machine/create', body: pointMachineEntity);
    if (appResponseHttp.isSuccessful) {
      return Success(
          data: PointMachineEntity.fromJson(jsonDecode(appResponseHttp.body)));
    } else {
      return Error(
          error: ErrorEntity(
              statusCode: appResponseHttp.statusCode,
              title: 'Error al crear el punto-máquina',
              errorMessage: appResponseHttp.body));
    }
  }

  @override
  Future<ResultType<List<PointMachineEntity>, ErrorEntity>>
      getPoinstMachine() async {
    AppHttpManager appHttpManager = AppHttpManager();
    AppResponseHttp appResponseHttp =
        await appHttpManager.get(url: '/point-machine');
    if (appResponseHttp.isSuccessful) {
      return Success(
          data: pointMachineEntityFromJsonList(appResponseHttp.body));
    } else {
      return Error(
          error: ErrorEntity(
              statusCode: appResponseHttp.statusCode,
              title: 'Error al listar los puntos',
              errorMessage: appResponseHttp.body));
    }
  }
}
