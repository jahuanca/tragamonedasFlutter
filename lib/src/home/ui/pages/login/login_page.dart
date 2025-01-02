import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traga_monedas/src/home/ui/pages/login/login_controller.dart';
import 'package:traga_monedas/src/utils/ui/ids_get.dart';
import 'package:utils/utils.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find<LoginController>();
    final Size size = MediaQuery.of(context).size;
    final SizedBox emptyContainer = SizedBox(height: size.height * 0.3);
    final EdgeInsets padding =
        EdgeInsets.symmetric(horizontal: size.height * 0.025);

    return GetBuilder<LoginController>(
      init: controller,
      builder: (controller) => Stack(
        children: [
          Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  height: size.height,
                  padding: padding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      emptyContainer,
                      Text(
                        'Ingresa ahora',
                        style: TextStyle(
                          fontSize: 20,
                          color: infoColor(),
                        ),
                      ),
                      GetBuilder<LoginController>(
                        id: emailIdGet,
                        builder: (_) => InputWidget(
                            maxLength: 50,
                            textInputType: TextInputType.emailAddress,
                            onChanged: controller.onChangedEmail,
                            error: controller.errorEmail,
                            icon: const Icon(Icons.person_outline),
                            hintText: 'Correo electrónico'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GetBuilder<LoginController>(
                        id: passwordIdGet,
                        builder: (_) => PasswordInputWidget(
                            onChanged: controller.onChangedPassword,
                            error: controller.errorPassword,
                            icon: const Icon(Icons.lock_outline),
                            hintText: 'Contraseña'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ButtonWidget(
                        onTap: controller.login,
                        text: 'Ingresar',
                        fontSize: 18,
                      ),
                      emptyContainer,
                    ],
                  ),
                ),
              ),
            ),
          ),
          GetBuilder<LoginController>(
            id: validandoIdGet,
            builder: (controller) => LoadingWidget(
              show: controller.validando,),
          ),
        ],
      ),
    );
  }
}
