import 'dart:convert';

import 'package:traga_monedas/src/home/data/requests/auth_request.dart';
import 'package:traga_monedas/src/home/domain/datastores/auth_datastore.dart';
import 'package:traga_monedas/src/home/domain/entities/user_entity.dart';
import 'package:utils/utils.dart';

class AuthDatastoreImplementation extends AuthDatastore {
  @override
  Future<ResultType<UserEntity, ErrorEntity>> login(
      AuthRequest authRequest) async {
    AppHttpManager appHttpManager = AppHttpManager();
    AppResponseHttp response = await appHttpManager.post(
      url: '/auth/login',
      body: authRequest
    );
    if (response.isSuccessful) {
      return Success(data: UserEntity.fromJson(jsonDecode(response.body)));
    } else {
      return Error(
          error: ErrorEntity(
              statusCode: response.statusCode,
              title: '',
              errorMessage: response.body));
    }
  }
}
