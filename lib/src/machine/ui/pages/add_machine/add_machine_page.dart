import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traga_monedas/src/machine/ui/pages/add_machine/add_machine_controller.dart';
import 'package:traga_monedas/src/utils/core/constants.dart';
import 'package:traga_monedas/src/utils/ui/ids_get.dart';
import 'package:utils/utils.dart';

class AddMachinePage extends StatelessWidget {
  const AddMachinePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AddMachineController controller = Get.find<AddMachineController>();
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<AddMachineController>(
      init: controller,
      builder: (controller) => Scaffold(
        appBar: appBarWidget(text: 'Agregar máquina', hasArrowBack: true),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 5, horizontal: size.width * 0.05),
                child: Column(
                  children: [
                    ImageActionWidget(
                        height: size.height * 0.2, width: size.width),
                    GetBuilder<AddMachineController>(
                      id: nameIdGet,
                      builder: (_) => InputWidget(
                        error: controller.errorName,
                        onChanged: controller.onChangedName,
                        label: 'Nombre',
                        hintText: 'Ingrese el nombre',
                      ),
                    ),
                    GetBuilder<AddMachineController>(
                      id: descriptionIdGet,
                      builder: (_) => InputWidget(
                        error: controller.errorDescription,
                        label: 'Descripción',
                        maxLength: minLengthOfDescription,
                        hintText: 'Ingrese la descripción',
                        onChanged: controller.onChangedDescription,
                      ),
                    ),
                    InputWidget(
                      label: 'Observación',
                      isTextArea: false,
                      hintText: 'Ingrese una observación',
                    ),
                    GetBuilder<AddMachineController>(
                      id: purchaseDateIdGet,
                      builder: (_) => InputWidget(
                        textEditingController: TextEditingController(
                          text: controller.purchaseDate.formatDMMYYY(),
                        ),
                        error: controller.errorPuchaseDate,
                        label: 'Fecha de compra',
                        hintText: 'Elija la fecha de compra',
                        enabled: false,
                        onTap: () async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 180)),
                            lastDate: DateTime.now(),
                          );
                          if (selectedDate != null) {
                            controller.onChangedPurchaseDate(selectedDate);
                          }
                        },
                      ),
                    ),
                    GetBuilder<AddMachineController>(
                      id: currencyValuesIdGet,
                      builder: (_)=> DropdownWidget(
                        label: 'Valor de la moneda',
                        value: controller.currencyValue,
                        items: controller.currencyValues,
                        onChanged: (value) => controller.onChangeCurrencyValue(value as String),
                      ),
                    ),
                    ButtonWidget(
                        onTap: controller.createMachine,
                        padding: const EdgeInsets.only(top: 20),
                        text: 'Crear'),
                  ],
                ),
              ),
            ),
            GetBuilder<AddMachineController>(
                id: validandoIdGet,
                builder: (_) => LoadingWidget(show: controller.validando))
          ],
        ),
      ),
    );
  }
}
