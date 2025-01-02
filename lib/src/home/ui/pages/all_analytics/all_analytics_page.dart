import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traga_monedas/src/home/ui/pages/all_analytics/all_analytics_controller.dart';
import 'package:traga_monedas/src/home/ui/pages/all_analytics/indicator.dart';
import 'package:traga_monedas/src/home/ui/pages/all_analytics/lines.dart';
import 'package:traga_monedas/src/home/ui/pages/all_analytics/pie.dart';
import 'package:utils/utils.dart';
import 'package:fl_chart/fl_chart.dart';

class AllAnalyticsPage extends StatelessWidget {
  const AllAnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<AllAnalyticsController>(
      id: pageIdGet,
      init: AllAnalyticsController(),
      builder: (controller) => Scaffold(
        appBar: appBarWidget(hasArrowBack: true, text: 'Analíticas'),
        body: _contentPie(controller: controller, size: size),
      ),
    );
  }

  Widget _contentPie({
    required AllAnalyticsController controller,
    required Size size,
  }) {

    List<PieChartMetaData>  values = controller.data.values.toList();
    values.sort((a, b) => b.amount.compareTo(a.amount),);          
    
    List<Widget> items = values.map((PieChartMetaData e) => Indicator(
                  total: e.amount,
                  porcentage: (e.amount / controller.allAmount * 100),
                  color: e.color,
                  text: e.name,
                  isSquare: true))
              .toList();


    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'Ingresos \n${controller.dateTimeRange?.start.orNow().formatDMMYYY()} - ${controller.dateTimeRange?.end.orNow().formatDMMYYY()}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: size.width,
          height: size.height * 0.4,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  /*setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });*/
                },
              ),
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              centerSpaceRadius: 50,
              sections: showingSections(
                data: controller.data.values.toList(),
                allAmount: controller.allAmount,
              ),
            ),
          ),
        ),
        
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items,
        ),
      ],
    );
  }
}

Widget _contentLines() {
  return AspectRatio(
    aspectRatio: 1.70,
    child: Padding(
      padding: const EdgeInsets.only(
        right: 18,
        left: 12,
        top: 24,
        bottom: 12,
      ),
      child: LineChart(
        mainData(),
      ),
    ),
  );
}
