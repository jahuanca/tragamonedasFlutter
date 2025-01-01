import 'package:get/get.dart';
import 'package:traga_monedas/src/home/data/requests/auth_request.dart';
import 'package:traga_monedas/src/home/di/main_binding.dart';
import 'package:traga_monedas/src/home/domain/entities/user_entity.dart';
import 'package:traga_monedas/src/home/domain/use_cases/login_use_case.dart';
import 'package:traga_monedas/src/home/ui/pages/main/main_page.dart';
import 'package:traga_monedas/src/utils/core/data_local.dart';
import 'package:traga_monedas/src/utils/ui/ids_get.dart';
import 'package:utils/utils.dart';

class LoginController extends GetxController {
  LoginUseCase loginUseCase;
  String? email;
  String? password;
  bool validando = false;
  String? errorEmail, errorPassword;

  LoginController({
    required this.loginUseCase,
  });

  void _goToMainContent() {
    Get.to(() => MainPage(), binding: MainBinding());
  }

  void onChangedEmail(String value){
    errorEmail = validatorText(
      label: 'Email',
      text: value,
      rules: {
        RuleValidator.isRequired: true,
      }
    );
    if(errorEmail == null){
      email = value;
    }
    update([emailIdGet]);
  }

  void onChangedPassword(String value){
    errorPassword = validatorText(
      label: 'Contraseña',
      text: value,
      rules: {
        RuleValidator.isRequired: true,
      }
    );
    if(errorPassword == null){
      password = value;
    }
    update([passwordIdGet]);
  }

  String? validar() {
    onChangedEmail(email.orEmpty());
    onChangedPassword(password.orEmpty());
    if(errorEmail != null) return errorEmail;
    if(errorPassword != null) return errorPassword;
    return null;
  }

  void login() async {
    String? mensaje = validar();
    if(mensaje != null) {
      showSnackbarWidget(
      context: Get.overlayContext!, 
      typeSnackbar: TypeSnackbar.error, 
      message: mensaje);
      return;
    }
    validando = true;
    update([validandoIdGet]);
    ResultType<UserEntity, ErrorEntity> resultType =
        await loginUseCase.execute(
          authRequest: AuthRequest(email: email.orEmpty(), password: password.orEmpty()));
    if(resultType is Success){
      DataLocal.setLogged(true);
      _goToMainContent();
    }else{ 

    }
    validando = false;
    update([validandoIdGet]);
  }
}
