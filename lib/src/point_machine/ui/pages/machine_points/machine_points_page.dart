import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traga_monedas/src/point_machine/ui/pages/machine_points/machine_points_controller.dart';
import 'package:traga_monedas/src/home/ui/widgets/empty_widget.dart';
import 'package:traga_monedas/src/point/domain/entities/point_machine_entity.dart';
import 'package:traga_monedas/src/utils/ui/constants_ui.dart';
import 'package:traga_monedas/src/utils/ui/ids_get.dart';
import 'package:utils/utils.dart';

class MachinePointsPage extends StatelessWidget {
  const MachinePointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MachinePointsController controller =
        Get.find<MachinePointsController>();
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<MachinePointsController>(
      init: controller,
      id: pageIdGet,
      builder: (controller) => Stack(
        children: [
          Scaffold(
            floatingActionButton: GetBuilder<MachinePointsController>(
              id: pointsMachineIdGet,
              builder: (_) => Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    heroTag: 'goAddPointMachine',
                    onPressed: controller.goAddPointMachine,
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(height: 15,),
                ],
              ),
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
            body: RefreshIndicator(
              onRefresh: controller.getPointsMachine,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: GetBuilder<MachinePointsController>(
                  id: pointsMachineIdGet,
                  builder: (_) => (controller.pointsMachine.isEmpty)
                      ? SizedBox(
                        height: size.height - kToolbarHeight,
                        child: const EmptyWidget())
                      : Column(
                          children: _slotsMachinePoint(
                            controller: controller,
                            size: size,
                          ),
                        ),
                ),
              ),
            ),
          ),
          GetBuilder<MachinePointsController>(
              id: validandoIdGet,
              builder: (_) => LoadingWidget(show: controller.validando)),
        ],
      ),
    );
  }

  List<Widget> _slotsMachinePoint({
    required Size size,
    required MachinePointsController controller,
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
    required MachinePointsController controller,
  }) {
    return ItemListImageDataWidget(
      onTap: () => controller.goToContentSlot(item),
      cardElevation: cardElevationItemConstant,
      decorationAll: decorationAllItemConstant,
      paddingAll: paddingAllItemConstant,
      paddingImage: defaultPadding,
      width: size.width,
      height: size.height * 0.15,
      path: 'assets/icons/icon_slot_machine.png',
      storageType: StorageType.localStorage,
      title: item.pointEntity?.alias ?? emptyString,
      subtitle: item.pointEntity?.firstName,
      detail: '${item.porcentage.formatDecimals()}%',
    );
  }
}
