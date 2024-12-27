import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traga_monedas/src/home/ui/pages/choose_slot_machine_point/choose_slot_machine_point_controller.dart';
import 'package:traga_monedas/src/point/domain/entities/point_machine_entity.dart';
import 'package:traga_monedas/src/utils/ui/ids_get.dart';
import 'package:utils/utils.dart';

class ChooseSlotMachinePointPage extends StatelessWidget {
  const ChooseSlotMachinePointPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ChooseSlotMachinePointController controller =
        Get.find<ChooseSlotMachinePointController>();
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<ChooseSlotMachinePointController>(
      init: controller,
      builder: (controller) => RefreshIndicator(
        onRefresh: controller.getPointsMachine,
        child: Stack(
          children: [
            Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: controller.goAddPointMachine,
                child: const Icon(Icons.add),
              ),
              appBar: appBarWidget(text: 'Seleccione un punto', actions: [
                const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ]),
              backgroundColor: cardColor(),
              body: SingleChildScrollView(
                child: GetBuilder<ChooseSlotMachinePointController>(
                  id: pointsMachineIdGet,
                  builder: (_)=> Column(
                    children: _slotsMachinePoint(
                      controller: controller,
                      size: size,
                    ),
                  ),
                ),
              ),
            ),
            GetBuilder<ChooseSlotMachinePointController>(
                id: validandoIdGet,
                builder: (_) => LoadingWidget(show: controller.validando)),
          ],
        ),
      ),
    );
  }

  List<Widget> _slotsMachinePoint({
    required Size size,
    required ChooseSlotMachinePointController controller,
  }) {
    List<Widget> pointsMachine = [];

    for (PointMachineEntity item in controller.pointsMachine) {
      pointsMachine.add(_itemPointMachine(
        controller: controller,
        size: size,
        item: item,
      ));
    }

    return pointsMachine;
  }

  Widget _itemPointMachine({
    required Size size,
    required PointMachineEntity item,
    required ChooseSlotMachinePointController controller,
  }) {
    return ItemListImageDataWidget(
      onTap: ()=> controller.goToContentSlotMachinePoint(item),
      cardElevation: 5,
      decorationAll: BoxDecoration(
          border: Border.all(color: primaryColor()),
          borderRadius: BorderRadius.circular(borderRadius())),
      paddingAll: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      paddingImage: defaultPadding,
      width: size.width,
      height: size.height * 0.15,
      path: 'assets/icons/icon_slot_machine.png',
      storageType: StorageType.localStorage,
      title: item.pointEntity?.alias ?? emptyString,
      subtitle: item.pointEntity?.address ?? emptyString,
      detail: item.porcentage.toString(),
      
    );
  }
}
