
import 'package:get/get.dart';
import 'package:traga_monedas/src/home/domain/entities/income_entity.dart';
import 'package:traga_monedas/src/utils/ui/arguments.dart';

class AllAnalyticsController extends GetxController {

  List<IncomeEntity> incomes = [];


  @override
  void onInit() {
    if(Get.arguments!= null){
      if(Get.arguments[incomesArgument] != null){
        incomes = Get.arguments[incomesArgument] as List<IncomeEntity>;
      }
    }
    super.onInit();
  }

}