import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traga_monedas/src/home/ui/pages/home_all_slot/home_all_slot_page.dart';
import 'package:traga_monedas/src/machine/ui/pages/machines/machines_page.dart';
import 'package:traga_monedas/src/point/ui/pages/points/clients_page.dart';
import 'package:traga_monedas/src/point_machine/ui/pages/machine_points/machine_points_page.dart';
import 'package:traga_monedas/src/home/ui/pages/main/main_controller.dart';
import 'package:traga_monedas/src/settings/ui/pages/settings/settings_page.dart';
import 'package:utils/utils.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final List<Widget> childrenPages = [
    const HomeAllSlotPage(),
    const MachinePointsPage(),
    const PointsPage(),
    const MachinesPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init:  MainController(),
      id: pageIdGet,
      builder: (controller)=> Scaffold(
        body: PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: childrenPages,
        ),
        bottomNavigationBar: BottomNavigationBarWidget(
          icons: [
            BottomNavigationItemWidget(
              icon: Icons.home, 
              title: 'Inicio'),
            BottomNavigationItemWidget(
              icon: Icons.person_pin_circle_outlined, 
              title: 'Puntos'),
            BottomNavigationItemWidget(
              icon: Icons.people_outline, 
              title: 'Clientes'),
            BottomNavigationItemWidget(
              icon: Icons.computer_outlined, 
              title: 'Máquinas'),
            BottomNavigationItemWidget(
              icon: Icons.settings_outlined, 
              title: 'Configuración'),
          ], 
          onTapItem: controller.onTapItem, 
          indexSelectedItem: controller.indexPage,
        ),
      ),
    );
  }
}