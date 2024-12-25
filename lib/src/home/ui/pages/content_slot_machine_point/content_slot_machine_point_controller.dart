
import 'package:get/get.dart';
import 'package:utils/utils.dart';

class ContentSlotMachinePointController extends GetxController {

  int indexPage = defaultInt;

  void onChangeIndexPage(int value){
    indexPage = value;
    update([pageIdGet]);
  }

}