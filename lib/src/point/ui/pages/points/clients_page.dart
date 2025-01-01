import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traga_monedas/src/point/ui/pages/points/clients_controller.dart';
import 'package:traga_monedas/src/utils/ui/constants_ui.dart';
import 'package:traga_monedas/src/utils/ui/ids_get.dart';
import 'package:utils/utils.dart';

class PointsPage extends StatelessWidget {
  const PointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ClientsController controller = Get.find<ClientsController>();
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<ClientsController>(
      id: pageIdGet,
      init: controller,
      builder: (_) => Stack(
        children: [
          RefreshIndicator(
            onRefresh: controller.getPoints,
            child: Scaffold(
              appBar: appBarWidget(text: 'Clientes'),
              body: GetBuilder<ClientsController>(
                id: pointsIdGet,
                builder: (_) => ListView.builder(
                    itemCount: controller.points.length,
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
                          title: controller.points[index].aliasAndName,
                          subtitle: controller.points[index].address,
                          detail: controller.points[index].phoneNumber,
                        )),
              ),
            ),
          ),
          GetBuilder<ClientsController>(
            id: validandoIdGet,
            builder: (_) => LoadingWidget(show: controller.validando),
          )
        ],
      ),
    );
  }
}
