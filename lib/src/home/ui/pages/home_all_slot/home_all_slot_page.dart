import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traga_monedas/src/home/domain/entities/income_entity.dart';
import 'package:traga_monedas/src/home/ui/pages/home_all_slot/home_all_slot_controller.dart';
import 'package:traga_monedas/src/home/ui/widgets/empty_widget.dart';
import 'package:utils/utils.dart';

class HomeAllSlotPage extends StatelessWidget {
  const HomeAllSlotPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeAllSlotController controller =
        Get.find<HomeAllSlotController>();
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<HomeAllSlotController>(
      init: controller,
      id: pageIdGet,
      builder: (controller) => Stack(
        children: [
          RefreshIndicator(
            onRefresh: controller.getIncomes,
            child: Scaffold(
              appBar: appBarWidget(
                  text: 'Todas los puntos',
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
                    _footer(controller: controller),
                    (controller.incomes.isEmpty)
                        ? const Expanded(child: EmptyWidget())
                        : Expanded(
                            child: _list(
                              controller: controller,
                              size: size,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
          GetBuilder<HomeAllSlotController>(
              id: validandoIdGet,
              builder: (_) => LoadingWidget(show: controller.validando)),
        ],
      ),
    );
  }

  Widget _chooseDates({
    required BuildContext context,
    required HomeAllSlotController controller,
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

  Widget _footer({required HomeAllSlotController controller}) {
    return Row(
      children: [
        _footerItem(
          title: 'Ingresos',
          value: controller.incomesInsert.formatDecimals(),
          color: infoColor(),
        ),
        _footerItem(
          title: 'Salidas',
          value: controller.incomesExit.formatDecimals(),
          color: dangerColor(),
        ),
        _footerItem(
          title: 'Ganancia',
          value: controller.gains.formatDecimals(),
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
    required HomeAllSlotController controller,
  }) {
    return ListView.builder(
      itemBuilder: (context, index) =>
          _itemList(item: controller.incomes[index], context: context),
      itemCount: controller.incomes.length,
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
            title: Row(
              children: [
                Text(
                  (item.typeIncome == 'Ingreso') ? ' +' : ' -',
                ),
                Text(
                  ' S/ ${item.amount.formatDecimals()}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            subtitle: Row(
              children: [
                Text(item.date
                    .format(formatDate: 'EEEE d/MM hh:mm a')
                    .orEmpty()),
              ],
            ),
            trailing: Icon(
              (item.isApproved ?? false)
                  ? Icons.check_outlined
                  : Icons.warning_outlined,
              color: (item.isApproved ?? false) ? successColor() : alertColor(),
            ),
          ),
        ),
      ),
    );
  }
}
