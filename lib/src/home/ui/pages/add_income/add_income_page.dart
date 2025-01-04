import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traga_monedas/src/home/ui/pages/add_income/add_income_controller.dart';
import 'package:traga_monedas/src/utils/ui/ids_get.dart';
import 'package:utils/utils.dart';

class AddIncomePage extends StatelessWidget {
  const AddIncomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AddIncomeController controller = Get.find<AddIncomeController>();
    final Size size = MediaQuery.of(context).size;
    final double paddingHorizontal = size.width * 0.05;

    return GetBuilder<AddIncomeController>(
      init: controller,
      id: pageIdGet,
      builder: (controller) => Scaffold(
        appBar: appBarWidget(hasArrowBack: true, text: 'Nuevo movimiento'),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
                child: Column(
                  children: [
                    GetBuilder<AddIncomeController>(
                      id: dateIdGet,
                      builder: (_) => InputWidget(
                        textEditingController: TextEditingController(
                          text: controller.date.formatDMMYYY(),
                        ),
                        error: controller.errorDate,
                        label: 'Fecha:',
                        hintText: 'Elija una fecha',
                        enabled: false,
                        onTap: () async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: controller.date ?? defaultDate,
                            firstDate:
                                defaultDate.subtract(const Duration(days: 180)),
                            lastDate: defaultDate,
                          );
                          if (selectedDate != null) {
                            controller.onChangeDate(selectedDate);
                          }
                        },
                      ),
                    ),
                    GetBuilder<AddIncomeController>(
                      id: typeIncomeIdGet,
                      builder: (_) => DropdownWidget(
                        onChanged: controller.onChangedTypeIncome,
                        items: controller.typesIncome,
                        value: controller.typeIncome,
                        hintText: 'Seleccione el tipo',
                        label: 'Tipo de movimiento: ',
                      ),
                    ),
                    GetBuilder<AddIncomeController>(
                      id: montoIdGet,
                      builder: (_) => InputWidget(
                        onChanged: controller.onChangeMonto,
                        hintText: 'Ingrese el monto',
                        label: 'Monto: ',
                        textInputType: TextInputType.number,
                      ),
                    ),
                    if (controller.typeIncome == controller.typeIncomeInsert)
                      InputWidget(
                          enabled: false,
                          hintText: 'Porcentaje:',
                          initialValue: controller.porcentage.formatDecimals(),
                          label: 'Porcentaje'),
                    if (controller.typeIncome == controller.typeIncomeInsert)
                      GetBuilder<AddIncomeController>(
                        id: forATMIdGet,
                        builder: (controller) => InputWidget(
                            enabled: false,
                            hintText: 'Calculando para la caja',
                            textEditingController: TextEditingController(
                                text: controller.forATM.formatDecimals()),
                            label: 'Para la caja:'),
                      ),
                    if (controller.typeIncome == controller.typeIncomeInsert)
                      GetBuilder<AddIncomeController>(
                        id: forClientIdGet,
                        builder: (_) => InputWidget(
                            enabled: false,
                            hintText: 'Porcentaje',
                            textEditingController: TextEditingController(
                                text: controller.forClient.formatDecimals()),
                            label: 'Para el cliente:'),
                      ),
                    if (controller.typeIncome == controller.typeIncomeInsert)
                      GetBuilder<AddIncomeController>(
                        id: withPayForClientIdGet,
                        builder: (_) => CheckBoxWidget(
                            onChanged: controller.onChangeWithPayClient,
                            isChecked: controller.withPayForClient.orFalse(),
                            label: 'Opcional:',
                            title: 'Se pago al cliente'),
                      ),
                    if (controller.typeIncome != controller.typeIncomeInsert)
                      GetBuilder<AddIncomeController>(
                        id: descriptionIdGet,
                        builder: (_) => InputWidget(
                            hintText: 'Describa la salida de dinero.',
                            isTextArea: true,
                            maxLength: 100,
                            onChanged: controller.onChangeDescription,
                            label: 'Descripción:'),
                      ),
                    ButtonWidget(
                        elevation: 5,
                        onTap: controller.createIncome,
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        text: 'Ingresar')
                  ],
                ),
              ),
            ),
            GetBuilder<AddIncomeController>(
              id: validandoIdGet,
              builder: (_) => LoadingWidget(show: controller.validando),
            )
          ],
        ),
      ),
    );
  }
}
