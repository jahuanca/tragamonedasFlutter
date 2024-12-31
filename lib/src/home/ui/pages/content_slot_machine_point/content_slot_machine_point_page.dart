import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traga_monedas/src/home/ui/pages/content_slot_machine_point/content_slot_machine_point_controller.dart';
import 'package:traga_monedas/src/home/ui/pages/home_slot/home_slot_page.dart';
import 'package:utils/utils.dart';


class ContentSlotMachinePointPage extends StatelessWidget {
  const ContentSlotMachinePointPage({super.key});

  @override
  Widget build(BuildContext context) {

    List<Widget> pages = [
      const HomeSlotPage(),
      const HomeSlotPage(),
    ];    


    return GetBuilder<ContentSlotMachinePointController>(
      init: ContentSlotMachinePointController(),
      id: pageIdGet,
      builder: (controller) => Scaffold(
        body: PageView(
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBarWidget(
          icons: [
            BottomNavigationItemWidget(
              icon: Icons.home, 
              title: 'Inicio'
            ),
            BottomNavigationItemWidget(
              icon: Icons.settings, 
              title: 'Configuración'
            ),
          ], 
          onTapItem: controller.onChangeIndexPage, 
          indexSelectedItem: controller.indexPage,
        ),
      ),
    );
  }
}