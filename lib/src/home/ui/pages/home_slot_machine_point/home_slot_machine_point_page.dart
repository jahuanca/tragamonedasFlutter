import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traga_monedas/src/home/domain/entities/income_entity.dart';
import 'package:traga_monedas/src/home/ui/pages/home_slot_machine_point/home_slot_machine_point_controller.dart';
import 'package:utils/utils.dart';

class HomeSlotMachinePointPage extends StatelessWidget {
  const HomeSlotMachinePointPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeSlotMachinePointController controller =
        Get.find<HomeSlotMachinePointController>();
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<HomeSlotMachinePointController>(
      init: controller,
      id: pageIdGet,
      builder: (controller) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: controller.goAddIncome,
          child: const Icon(Icons.add),
        ),
        appBar: appBarWidget(
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                child: Text('HD'),
              ),
            ),
            text: controller.pointMachineEntity?.pointEntity?.alias ??
                emptyString,
            actions: [
              const IconWidget(
                padding: EdgeInsets.only(right: 8),
                iconData: Icons.search,
              ),
            ]),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              _chooseDates(controller: controller, context: context),
              _footer(),
              _list(
                controller: controller,
                size: size,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chooseDates({
    required BuildContext context,
    required HomeSlotMachinePointController controller,
  }) {
    String initialDay = controller.initialDay.formatDMMYYY() ?? emptyString;
    String finalDay = controller.finalDay.formatDMMYYY() ?? emptyString;
    String rangeDateString = '$initialDay - $finalDay';

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      child: GestureDetector(
        onTap: () => showDateRangePicker(
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 7)),
            context: context,
            initialEntryMode: DatePickerEntryMode.calendar),
        child: Row(
          children: [
            const Icon(Icons.date_range_outlined),
            Expanded(
                child: Text(
              rangeDateString,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ))
          ],
        ),
      ),
    );
  }

  Widget _footer() {
    return Row(
      children: [
        _footerItem(
          title: 'Ingresos',
          value: '550.30',
          color: infoColor(),
        ),
        _footerItem(
          title: 'Salidas',
          value: '200.20',
          color: dangerColor(),
        ),
        _footerItem(
          title: 'Ganancia',
          value: '350.20',
          color: successColor(),
        ),
      ],
    );
  }

  Widget _footerItem({
    required String value,
    required String title,
    Color color = Colors.white,
  }) {
    const TextStyle titleStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
    );

    const TextStyle valueStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );

    return Expanded(
      flex: 1,
      child: Card(
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
              color: color.withAlpha(50),
              border: Border.all(
                color: color,
              ),
              borderRadius: BorderRadius.circular(borderRadius())),
          child: Column(
            children: [
              Text(
                title,
                style: titleStyle,
              ),
              Text(
                'S/ $value',
                style: valueStyle,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _list({
    required Size size,
    required HomeSlotMachinePointController controller,
  }) {
    return SizedBox(
      height: size.height * 0.65,
      child: ListView.builder(
        itemBuilder: (context, index) =>
            _itemList(item: controller.incomes[index], context: context),
        itemCount: controller.incomes.length,
      ),
    );
  }

  Widget _itemList({
    required IncomeEntity item,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 5,
        child: SizedBox(
          height: 75,
          child: ListTile(
            title: Text(
              'S/ ${item.amount}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: (item.typeIncome == 'Ingreso')
                ? const Icon(Icons.add)
                : const Icon(Icons.remove),
            subtitle: Text(item.date.format(formatDate: 'EEEE d/MM hh:mm a').orEmpty()),
            trailing: CircleAvatar(
              radius: 15,
              backgroundColor:
                  (item.isApproved ?? false) ? successColor() : alertColor(),
              child: Icon(
                (item.isApproved ?? false) ? Icons.check : Icons.warning,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
