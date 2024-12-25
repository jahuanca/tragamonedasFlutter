
import 'package:traga_monedas/src/home/data/requests/auth_request.dart';
import 'package:traga_monedas/src/home/domain/entities/user_entity.dart';
import 'package:utils/utils.dart';

abstract class AuthRepository {

  Future<ResultType<UserEntity, ErrorEntity>> login(AuthRequest authRequest);

}