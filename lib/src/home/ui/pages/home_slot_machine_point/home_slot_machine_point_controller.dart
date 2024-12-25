
import 'package:get/get.dart';
import 'package:traga_monedas/src/home/ui/pages/add_income/add_income_page.dart';
import 'package:utils/utils.dart';

class HomeSlotMachinePointController extends GetxController {

  DateTime? initialDay;
  DateTime? finalDay;

  @override
  void onInit() {
    initialDay = DateTime.now().subtract(
      Duration(days: (DateTime.now().weekday - 1))
    );
    finalDay = DateTime.now().add(
      Duration(days: DateTime.daysPerWeek - DateTime.now().weekday)
    );
    update([pageIdGet]);
    super.onInit();
  }

  void goAddIncome(){
    Get.to(()=> const AddIncomePage());
  }


}