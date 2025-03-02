import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traga_monedas/src/point/ui/pages/add_point/add_point_controlller.dart';
import 'package:traga_monedas/src/utils/ui/ids_get.dart';
import 'package:utils/utils.dart';

class AddPointPage extends StatelessWidget {
  const AddPointPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AddPointController controller = Get.find<AddPointController>();
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<AddPointController>(
      init: controller,
      builder: (controller) => Scaffold(
        appBar: appBarWidget(hasArrowBack: true, text: controller.titlePage),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 5, horizontal: size.width * 0.05),
                child: Column(
                  children: [
                    GetBuilder<AddPointController>(
                        id: nameIdGet,
                        builder: (_) => InputWidget(
                            initialValue: controller.firstName,
                            onChanged: controller.onChangedName,
                            label: 'Nombre',
                            hintText: 'Ingrese el nombre')),
                    GetBuilder<AddPointController>(
                        id: lastNameIdGet,
                        builder: (_) => InputWidget(
                            initialValue: controller.lastName,
                            onChanged: controller.onChangedLastName,
                            label: 'Apellido',
                            hintText: 'Ingrese el apellido')),
                    GetBuilder<AddPointController>(
                        id: phoneNumberIdGet,
                        builder: (_) => InputWidget(
                            maxLength: 9,
                            initialValue: controller.phoneNumber,
                            textInputType: TextInputType.phone,
                            onChanged: controller.onChangedPhoneNumber,
                            label: 'Teléfono',
                            hintText: 'Ingrese el teléfono')),
                    GetBuilder<AddPointController>(
                        id: emailIdGet,
                        builder: (_) => InputWidget(
                            initialValue: controller.email,
                            textInputType: TextInputType.emailAddress,
                            onChanged: controller.onChangedEmail,
                            label: 'Correo electronico',
                            hintText: 'Ingrese el correo electronico')),
                    GetBuilder<AddPointController>(
                      id: porcentageIdGet,
                      builder: (_) => InputWidget(
                          initialValue: controller.porcentage,
                          onChanged: controller.onChangedPorcentage,
                          label: 'Porcentaje negociado',
                          iconOverlay: Icons.view_compact_outlined,
                          textInputType: TextInputType.number,
                          hintText: 'Ingrese el porcentaje'),
                    ),
                    GetBuilder<AddPointController>(
                      id: payWeeklyIdGet,
                      builder: (_) => CheckBoxWidget(
                        isChecked: controller.payWeekly.orFalse(),
                        title: 'Pagar semanalmente',
                        onChanged: controller.onChangePayWeekly,
                        label: 'Pagar semanalmente',
                      ),
                    ),
                    GetBuilder<AddPointController>(
                        id: aliasIdGet,
                        builder: (_) => InputWidget(
                            initialValue: controller.alias,
                            onChanged: controller.onChangedAlias,
                            label: 'Alias',
                            hintText: 'Ingrese un alias')),
                    GetBuilder<AddPointController>(
                        id: addressIdGet,
                        builder: (_) => InputWidget(
                            initialValue: controller.address,
                            onChanged: controller.onChangedAddress,
                            label: 'Dirección',
                            maxLength: 50,
                            hintText: 'Ingrese la dirección')),
                    _itemOfMap(controller: controller),
                    ButtonWidget(
                        elevation: 12,
                        onTap: controller.createPoint,
                        padding: const EdgeInsets.only(top: 20),
                        text: controller.editing ? 'Editar' : 'Crear'),
                  ],
                ),
              ),
            ),
            GetBuilder<AddPointController>(
                id: validandoIdGet,
                builder: (_) => LoadingWidget(show: controller.validando))
          ],
        ),
      ),
    );
  }

  Widget _itemOfMap({
    required AddPointController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: GestureDetector(
        onTap: controller.goChooseDirection,
        child: Card(
          child: ListTile(
            leading: CircleAvatar(
                backgroundColor: primaryColor(),
                child: const Icon(
                  Icons.map,
                  color: Colors.white,
                )),
            trailing: Icon(
              Icons.warning_outlined,
              color: alertColor(),
            ),
            title: const Text('Sin ubicación'),
            subtitle: const Text('Ubicación pendiente'),
          ),
        ),
      ),
    );
  }
}
