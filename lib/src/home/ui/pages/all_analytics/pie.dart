import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:traga_monedas/src/home/ui/pages/all_analytics/all_analytics_controller.dart';
import 'package:utils/utils.dart';

List<PieChartSectionData> showingSections({
  required List<PieChartMetaData> data,
  required double allAmount,
}) {
  return data
      .map((e) => PieChartSectionData(
          color: e.color,
          value: e.amount,
          title: '${(e.amount / allAmount * 100).formatDecimals()} %',
          radius: 60.0,
          titleStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            shadows: [Shadow(color: Colors.black, blurRadius: 2)],
          )))
      .toList();
}

//final isTouched = i == 2;
//final fontSize = isTouched ? 25.0 : 16.0;
//final radius = isTouched ? 60.0 : 50.0;
//const shadows = [Shadow(color: Colors.black, blurRadius: 2)];