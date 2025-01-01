import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traga_monedas/src/settings/ui/pages/settings/settings_controller.dart';
import 'package:utils/utils.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      id: pageIdGet,
      init: SettingsController(),
      builder: (controller) => Scaffold(
        appBar: appBarWidget(text: 'Configuraciones'),
        body: Column(
          children: [
            ListTile(
              onTap: controller.goExitApp,
              title: const Text('Cerrar sesión'),
              leading: const Icon(Icons.exit_to_app_outlined),
            )
          ],
        ),
      ),
    );
  }
}
