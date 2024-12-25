import 'package:get/get.dart';
import 'package:traga_monedas/src/utils/ui/ids_get.dart';
import 'package:utils/utils.dart';

class AddIncomeController extends GetxController {
  double forClient = defaultDouble;
  double forATM = defaultDouble;

  void onChangeMonto(String value) {
    String? error = validatorText(text: value, label: 'monto', rules: {
      RuleValidator.isRequired: true,
      RuleValidator.isDouble: true,
    });

    if (error == null) {
      double income = double.parse(value);
      forClient = income * 0.25;
      forATM = income * 0.75;
    }else {
      forClient = defaultDouble;
      forATM = defaultDouble;
    }
    update([forClientIdGet, forATMIdGet]);
  }
}
