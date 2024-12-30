import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traga_monedas/src/point/ui/pages/add_point/add_point_controlller.dart';
import 'package:traga_monedas/src/utils/ui/ids_get.dart';
import 'package:utils/utils.dart';

class AddPointPage extends StatelessWidget {
  const AddPointPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AddPointControlller controller = Get.find<AddPointControlller>();
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<AddPointControlller>(
      init: controller,
      builder: (controller) => Scaffold(
        appBar: appBarWidget(hasArrowBack: true, text: 'Agregar punto'),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 5, horizontal: size.width * 0.05),
                child: Column(
                  children: [
                    GetBuilder<AddPointControlller>(
                        id: nameIdGet,
                        builder: (_) => InputWidget(
                            onChanged: controller.onChangedName,
                            label: 'Nombre', hintText: 'Ingrese el nombre')),
                    GetBuilder<AddPointControlller>(
                        id: lastNameIdGet,
                        builder: (_) => InputWidget(
                          onChanged: controller.onChangedLastName,
                            label: 'Apellido',
                            hintText: 'Ingrese el apellido')),
                    GetBuilder<AddPointControlller>(
                        id: phoneNumberIdGet,
                        builder: (_) => InputWidget(
                          maxLength: 9,
                          onChanged: controller.onChangedPhoneNumber,
                            label: 'Teléfono',
                            hintText: 'Ingrese el teléfono')),
                    GetBuilder<AddPointControlller>(
                        id: emailIdGet,
                        builder: (_) => InputWidget(
                          onChanged: controller.onChangedEmail,
                            label: 'Correo electronico',
                            hintText: 'Ingrese el correo electronico')),
                    GetBuilder<AddPointControlller>(
                      id: porcentageIdGet,
                      builder: (_) => InputWidget(
                        onChanged: controller.onChangedPorcentage,
                          label: 'Porcentaje negociado',
                          iconOverlay: Icons.view_compact_outlined,
                          textInputType: TextInputType.number,
                          hintText: 'Ingrese el porcentaje'),
                    ),
                    GetBuilder<AddPointControlller>(
                        id: aliasIdGet,
                        builder: (_) => InputWidget(
                          onChanged: controller.onChangedAlias,
                            label: 'Alias', hintText: 'Ingrese un alias')),
                    GetBuilder<AddPointControlller>(
                        id: addressIdGet,
                        builder: (_) => InputWidget(
                          onChanged: controller.onChangedAddress,
                            label: 'Dirección',
                            maxLength: 50,
                            hintText: 'Ingrese la dirección')),
                    _itemOfMap(),
                    ButtonWidget(
                        elevation: 12,
                        onTap: controller.createPoint,
                        padding: const EdgeInsets.only(top: 20),
                        text: 'Crear'),
                  ],
                ),
              ),
            ),
            GetBuilder<AddPointControlller>(
                id: validandoIdGet,
                builder: (_) => LoadingWidget(show: controller.validando))
          ],
        ),
      ),
    );
  }

  Widget _itemOfMap() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: GestureDetector(
        onTap: null,
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
