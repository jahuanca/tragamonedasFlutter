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
    final double paddingHeigth = size.width * 0.05;

    return GetBuilder<AddPointMachineController>(
      id: pageIdGet,
      init: controller,
      builder: (controller) => ScaffoldMessenger(
        child: Scaffold(
          appBar:
              appBarWidget(hasArrowBack: true, text: 'Asociar punto y máquina'),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 5, horizontal: paddingHeigth),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: (size.width * 0.65) - paddingHeigth,
                            child: GetBuilder<AddPointMachineController>(
                              id: pointsIdGet,
                              builder: (_) => DropdownMenuWidget(
                                label: 'Punto',
                                idLabel: 'alias',
                                idValue: 'id',
                                items: controller.points,
                                onChanged: controller.onChangePoint,
                              ),
                            ),
                          ),
                          SizedBox(
                              width: (size.width * 0.3) - paddingHeigth,
                              child: ButtonWidget(
                                  fontSize: 14,
                                  onTap: controller.goAddPoint,
                                  text: 'Agregar'))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: (size.width * 0.65) - paddingHeigth,
                            child: GetBuilder<AddPointMachineController>(
                              id: machinesIdGet,
                              builder: (_) => DropdownMenuWidget(
                                label: 'Maquina',
                                idLabel: 'name',
                                idValue: 'id',
                                items: controller.machines,
                                onChanged: controller.onChangeMachine,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: (size.width * 0.3) - paddingHeigth,
                            child: ButtonWidget(
                                fontSize: 14,
                                onTap: controller.goAddMachine,
                                text: 'Agregar'),
                          ),
                        ],
                      ),
                      GetBuilder<AddPointMachineController>(
                        id: porcentageIdGet,
                        builder: (_) => InputWidget(
                            textInputType: TextInputType.number,
                            textEditingController:
                                controller.porcentageSelected == null
                                    ? null
                                    : TextEditingController(
                                        text: controller.porcentageSelected
                                            ?.formatDecimals(),
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
      ),
    );
  }
}
