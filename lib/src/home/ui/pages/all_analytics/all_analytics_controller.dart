
import 'package:get/get.dart';
import 'package:traga_monedas/src/home/domain/entities/income_entity.dart';
import 'package:traga_monedas/src/utils/core/constants.dart';
import 'package:traga_monedas/src/utils/ui/arguments.dart';
import 'package:utils/utils.dart';
import 'package:flutter/material.dart';

class PieChartMetaData{
  Color color;
  String name;
  double amount;

  PieChartMetaData({
    required this.color,
    required this.name,
    required this.amount,
  });

}

class AllAnalyticsController extends GetxController {

  List<IncomeEntity> incomes = [];
  List<String> namePoints = [];
  Map<String, PieChartMetaData> data = {};
  DateTimeRange? dateTimeRange;
  double allAmount = 0;

  @override
  void onInit() {
    if(Get.arguments!= null){
      if(Get.arguments[incomesArgument] != null){
        incomes = Get.arguments[incomesArgument] as List<IncomeEntity>;
      }
      if(Get.arguments[rangeDateArgument] != null){
        dateTimeRange = Get.arguments[rangeDateArgument] as DateTimeRange;
      }
    }
    super.onInit();
  }

  @override
  void onReady() {
    setData();
    super.onReady();
  }

  void setData(){
    for (IncomeEntity income in incomes) {
      String name = income.pointMachineEntity?.pointEntity?.alias ?? emptyString;
      int position = data.entries.length;
      int typeIncome = (income.typeIncome == 'Ingreso') ? 1 : -1;
      allAmount = allAmount + (typeIncome * income.amount);

      PieChartMetaData? pieChartMetaData = data[income.idPointMachine.toString()];
      if(pieChartMetaData == null){
        data[income.idPointMachine.toString()] = PieChartMetaData(
        color: colorsToAnalytics[position], name: name, amount: typeIncome * (income.amount));
      }else{
        data[income.idPointMachine.toString()]?.amount = pieChartMetaData.amount + (typeIncome * income.amount);
      }
      
    }
    update([pageIdGet]);
  }

}