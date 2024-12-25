import 'package:traga_monedas/src/home/data/requests/auth_request.dart';
import 'package:traga_monedas/src/home/domain/entities/user_entity.dart';
import 'package:traga_monedas/src/home/domain/repositories/auth_repository.dart';
import 'package:utils/utils.dart';

class LoginUseCase {
  AuthRepository repository;

  LoginUseCase({
    required this.repository,
  });

  Future<ResultType<UserEntity, ErrorEntity>> execute({
    required AuthRequest authRequest,
  }) =>
      repository.login(authRequest);
}
