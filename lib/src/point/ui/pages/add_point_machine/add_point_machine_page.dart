import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traga_monedas/src/point/ui/pages/add_point_machine/add_point_machine_controller.dart';
import 'package:traga_monedas/src/utils/ui/ids_get.dart';
import 'package:utils/utils.dart';

class AddPointMachinePage extends StatelessWidget {
  const AddPointMachinePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AddPointMachineController controller =
        Get.find<AddPointMachineController>();
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<AddPointMachineController>(
      id: pageIdGet,
      init: controller,
      builder: (controller) => Scaffold(
        appBar:
            appBarWidget(hasArrowBack: true, text: 'Asociar punto y máquina'),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 5, horizontal: size.width * 0.05),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: GetBuilder<AddPointMachineController>(
                            id: pointsIdGet,
                            builder: (_) => DropdownWidget(
                              label: 'Punto',
                              idLabel: 'alias',
                              idValue: 'id',
                              items: controller.points,
                              onChanged: controller.onChangePoint,
                            ),
                          ),
                        ),
                        Expanded(child: ButtonWidget(
                          onTap: controller.goAddPoint,
                          text: 'Agregar'))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: GetBuilder<AddPointMachineController>(
                            id: machinesIdGet,
                            builder: (_) => DropdownWidget(
                              label: 'Maquina',
                              idLabel: 'name',
                              idValue: 'id',
                              items: controller.machines,
                              onChanged: controller.onChangeMachine,
                            ),
                          ),
                        ),
                        Expanded(child: ButtonWidget(
                          onTap: controller.goAddMachine,
                          text: 'Agregar'))
                      ],
                    ),
                    GetBuilder<AddPointMachineController>(
                      id: porcentageIdGet,
                      builder: (_) => InputWidget(
                          textEditingController:
                              controller.porcentageSelected == null
                                  ? null
                                  : TextEditingController(
                                      text: controller.porcentageSelected
                                          .toString(),
                                    ),
                          label: 'Porcentaje',
                          hintText: 'Ingrese el porcentaje'),
                    ),
                    ButtonWidget(
                        onTap: controller.createPointMachine,
                        padding: const EdgeInsets.only(top: 20),
                        text: 'Crear'),
                  ],
                ),
              ),
            ),
            GetBuilder<AddPointMachineController>(
                id: validandoIdGet,
                builder: (_) => LoadingWidget(show: controller.validando)),
          ],
        ),
      ),
    );
  }
}
