import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traga_monedas/src/home/ui/pages/all_analytics/all_analytics_controller.dart';
import 'package:traga_monedas/src/home/ui/pages/all_analytics/indicator.dart';
import 'package:traga_monedas/src/home/ui/pages/all_analytics/lines.dart';
import 'package:traga_monedas/src/home/ui/pages/all_analytics/pie.dart';
import 'package:utils/utils.dart';
import 'package:fl_chart/fl_chart.dart';

class AllAnalyticsPage extends StatelessWidget {
  AllAnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllAnalyticsController>(
      id: pageIdGet,
      init: AllAnalyticsController(),
      builder: (controller) => Scaffold(
        appBar: appBarWidget(hasArrowBack: true, text: 'Analíticas'),
        body: _contentPie(),
      ),
    );
  }

  Widget _contentPie() {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
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
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Indicator(
                color: infoColor(),
                text: 'First',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: alertColor(),
                text: 'Second',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Colors.purple,
                text: 'Third',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: successColor(),
                text: 'Fourth',
                isSquare: true,
              ),
              SizedBox(
                height: 18,
              ),
            ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
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
