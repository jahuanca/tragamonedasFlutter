import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traga_monedas/src/machine/ui/pages/machines/machines_controller.dart';
import 'package:traga_monedas/src/utils/ui/constants_ui.dart';
import 'package:traga_monedas/src/utils/ui/ids_get.dart';
import 'package:utils/utils.dart';

class MachinesPage extends StatelessWidget {
  const MachinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MachinesController controller = Get.find<MachinesController>();
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<MachinesController>(
      id: pageIdGet,
      init: controller,
      builder: (_) => Stack(
        children: [
          RefreshIndicator(
            onRefresh: controller.getMachines,
            child: Scaffold(
              appBar: appBarWidget(text: 'Máquinas'),
              body: GetBuilder<MachinesController>(
                id: machinesIdGet,
                builder: (_) => ListView.builder(
                    itemCount: controller.machines.length,
                    itemBuilder: (context, index) => ItemListImageDataWidget(
                          cardElevation: cardElevationItemConstant,
                          decorationAll: decorationAllItemConstant,
                          paddingAll: paddingAllItemConstant,
                          paddingImage: defaultPadding,
                          width: size.width,
                          height: size.height * 0.15,
                          storageType: StorageType.localStorage,
                          path:
                              'packages/utils/assets/images/image_not_found.png',
                          title: controller.machines[index].name,
                          subtitle: controller.machines[index].currencyValue,
                        )),
              ),
            ),
          ),
          GetBuilder<MachinesController>(
            id: validandoIdGet,
            builder: (_) => LoadingWidget(show: controller.validando),
          )
        ],
      ),
    );
  }
}
