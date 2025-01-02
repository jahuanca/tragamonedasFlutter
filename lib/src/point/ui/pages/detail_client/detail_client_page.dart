import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traga_monedas/src/point/domain/entities/point_entity.dart';
import 'package:traga_monedas/src/point/ui/pages/detail_client/detail_client_controller.dart';
import 'package:utils/utils.dart';

class DetailClientPage extends StatelessWidget {
  const DetailClientPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<DetailClientController>(
      id: pageIdGet,
      init: DetailClientController(),
      builder: (controller) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: controller.goEdit,
          child: const Icon(Icons.edit_outlined),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _header(
                size: size,
                controller: controller,
              ),
              _data(size: size, controller: controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _data({
    required Size size,
    required DetailClientController controller,
  }) {
    PointEntity point = controller.pointEntity!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            top: 16,
            left: 16,
            bottom: 8,
          ),
          child: Text(
            'Información del cliente:',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        _listTileItem(
          icon: Icons.person_outline,
          title: 'Nombre',
          subtitle: point.fullName,
        ),
        _listTileItem(
          icon: Icons.house_outlined,
          title: 'Dirección',
          subtitle: point.address,
        ),
        _listTileItem(
          icon: Icons.phone_android_outlined,
          title: 'Celular',
          subtitle: point.phoneNumber,
        ),
        _listTileItem(
          icon: Icons.email_outlined,
          title: 'Email',
          subtitle: point.email,
        ),
      ],
    );
  }

  Widget _listTileItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      iconColor: primaryColor(),
      leading: CircleAvatar(
          backgroundColor: primaryColor(),
          child: Icon(
            icon,
            color: Colors.white,
          )),
      title: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
          )),
    );
  }

  Widget _header({
    required Size size,
    required DetailClientController controller,
  }) {
    PointEntity point = controller.pointEntity!;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(0),
      child: Container(
        height: size.height * 0.47,
        decoration: BoxDecoration(
            color: primaryColor(),
            borderRadius: BorderRadius.circular(borderRadius())),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            appBarWidget(
                colorIconTheme: Colors.white,
                titleTextStyle: const TextStyle(color: Colors.white),
                shadowColor: Colors.transparent,
                elevation: defaultDouble,
                backgroundColor: Colors.transparent,
                hasArrowBack: true,
                text: point.alias),
            Column(
              children: [
                const ImageActionWidget(height: 75, width: 75),
                Text(
                  point.fullName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  '${point.porcentage.formatDecimals()} %',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            _itemsAction(),
          ],
        ),
      ),
    );
  }

  Widget _itemsAction() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _action(icon: Icons.call_outlined, title: 'Llamar'),
          _action(icon: Icons.sms_outlined, title: 'Mensaje'),
          _action(icon: Icons.waving_hand_outlined, title: 'Whatsapp'),
          _action(icon: Icons.email_outlined, title: 'Email'),
        ],
      ),
    );
  }

  Widget _action({
    required IconData icon,
    required String title,
  }) {
    const double dimenContainer = 85;
    const Color color = Colors.white;
    return Container(
      width: dimenContainer,
      height: dimenContainer,
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(borderRadius()),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconWidget(
              iconData: icon,
              color: color,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
