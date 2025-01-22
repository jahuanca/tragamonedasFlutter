import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traga_monedas/src/home/ui/pages/home_slot/home_slot_controller.dart';
import 'package:traga_monedas/src/home/ui/pages/home_slot/options_menu.dart';
import 'package:traga_monedas/src/utils/ui/ids_get.dart';
import 'package:utils/utils.dart';

List<Widget> actionsNormal({
  required HomeSlotController controller,
}) => [
  const Padding(
    padding: EdgeInsets.all(8.0),
    child: CircleAvatar(
      child: Text('HD'),
    ),
  ),
  MenuOverlayWidget(
    items: OptionsMenuReport.values.toList(), 
    onTapItem: (e)=> controller.onTapReport(e),
  )
];

List<Widget> actionsSeletected({
  required HomeSlotController controller,
}) {
  final idsFilled = controller.idsSelecteds.length == controller.incomes.length;

  return [
    GetBuilder<HomeSlotController>(
        id: actionsIdGet,
        builder: (controller) =>
            Text(controller.idsSelecteds.length.toString())),
    GetBuilder<HomeSlotController>(
      id: actionsIdGet,
      builder: (controller) => IconWidget(
        onTap: idsFilled ? controller.unselectAll : controller.selectAll,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        iconData: idsFilled ? Icons.tab_unselected_rounded : Icons.select_all,
      ),
    ),
    IconWidget(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        onTap: controller.resetView,
        iconData: Icons.close),
  ];
}
