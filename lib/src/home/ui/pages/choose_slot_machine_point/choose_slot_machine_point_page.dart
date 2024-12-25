import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traga_monedas/src/home/ui/pages/choose_slot_machine_point/choose_slot_machine_point_controller.dart';
import 'package:traga_monedas/src/home/ui/pages/choose_slot_machine_point/points_machine.dart';
import 'package:utils/utils.dart';

class ChooseSlotMachinePage extends StatelessWidget {
  const ChooseSlotMachinePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<ChooseSlotMachinePointController>(
      init: ChooseSlotMachinePointController(),
      builder: (controller) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: controller.goAddPointMachine,
          child: const Icon(Icons.add),
        ),
        appBar: appBarWidget(
          text: 'Seleccione un punto',
          actions: [
            const IconButton(
              onPressed: null, 
            icon: Icon(Icons.search, color: Colors.black,),
            ),
          ] 
          ),
        backgroundColor: cardColor(),
        body: SingleChildScrollView(
          child: Column(
            children: _slotsMachinePoint(
              controller: controller,
              size: size,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _slotsMachinePoint({
    required Size size,
    required ChooseSlotMachinePointController controller,
  }) {
    List<Widget> pointsMachine = [];

    for (int index in [0, 1, 2, 3]) {
      pointsMachine.add(_itemPointMachine(
        controller: controller,
        size: size,
        index: index,
      ));
    }

    return pointsMachine;
  }

  Widget _itemPointMachine({
    required Size size,
    required int index,
    required ChooseSlotMachinePointController controller,
  }) {
    Map<String, String> pointMachine = pointsMachine.elementAt(index);

    return ItemListImageDataWidget(
      onTap: controller.goToContentSlotMachinePoint,
      cardElevation: 5,
      decorationAll: BoxDecoration(
        border: Border.all(color: primaryColor()),
        borderRadius: BorderRadius.circular(borderRadius())
      ),
      paddingAll: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16
      ),
      paddingImage: defaultPadding,
      width: size.width,
      height: size.height * 0.15,
      path: 'assets/icons/icon_slot_machine.png',
      storageType: StorageType.localStorage,
      title: pointMachine['title'].orEmpty(),
      subtitle: pointMachine['direction'],
      detail: pointMachine['machine_name'],
    );
  }
}
