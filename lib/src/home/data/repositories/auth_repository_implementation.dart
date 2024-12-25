import 'package:traga_monedas/src/home/data/requests/auth_request.dart';
import 'package:traga_monedas/src/home/domain/datastores/auth_datastore.dart';
import 'package:traga_monedas/src/home/domain/entities/user_entity.dart';
import 'package:traga_monedas/src/home/domain/repositories/auth_repository.dart';
import 'package:utils/utils.dart';

class AuthRepositoryImplementation extends AuthRepository {
  AuthDatastore datastore;

  AuthRepositoryImplementation({
    required this.datastore,
  });

  @override
  Future<ResultType<UserEntity, ErrorEntity>> login(AuthRequest authRequest) =>
      datastore.login(authRequest);
}
