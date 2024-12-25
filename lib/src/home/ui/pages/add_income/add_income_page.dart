import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traga_monedas/src/home/ui/pages/add_income/add_income_controller.dart';
import 'package:traga_monedas/src/utils/ui/ids_get.dart';
import 'package:utils/utils.dart';

class AddIncomePage extends StatelessWidget {
  const AddIncomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double paddingHorizontal = size.width * 0.05;

    return GetBuilder<AddIncomeController>(
      init: AddIncomeController(),
      id: pageIdGet,
      builder: (controller) => Stack(
        children: [
          Scaffold(
            appBar: appBarWidget(
              hasArrowBack: true,
              text: 'Nuevo ingreso'
              ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
              child: Column(
                children: [
                  GetBuilder<AddIncomeController>(
                    id: montoIdGet,
                    builder: (_) => InputWidget(
                      onChanged: controller.onChangeMonto,
                      hintText: 'Ingrese el monto',
                      label: 'Monto: ',
                      textInputType: TextInputType.number,
                    ),
                  ),
                  InputWidget(
                      enabled: false,
                      hintText: 'Porcentaje:',
                      initialValue: '25%',
                      label: 'Porcentaje'),
                  GetBuilder<AddIncomeController>(
                    id: forATMIdGet,
                    builder: (controller) => InputWidget(
                        enabled: false,
                        hintText: 'Calculando para la caja',
                        textEditingController:
                            TextEditingController(text: controller.forATM.toString()),
                        label: 'Para la caja:'),
                  ),
                  GetBuilder<AddIncomeController>(
                    id: forClientIdGet,
                    builder: (_) => InputWidget(
                        enabled: false,
                        hintText: 'Porcentaje',
                        textEditingController:
                            TextEditingController(text: controller.forClient.toString()),
                        label: 'Para el cliente:'),
                  ),
                  const CheckBoxWidget(
                    onChanged: print,
                    isChecked: true,
                    label: 'Opcional:',
                    title: 'Se pago al cliente'),
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: ButtonWidget(
                  elevation: 5, 
                  padding: EdgeInsets.symmetric(
                    horizontal: paddingHorizontal,
                    vertical: 25
                  ),
                  text: 'Ingresar')),
        ],
      ),
    );
  }
}
