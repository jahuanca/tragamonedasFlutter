import 'package:get/get.dart';
import 'package:traga_monedas/src/home/data/requests/point_machine_request.dart';
import 'package:traga_monedas/src/home/di/add_income_binding.dart';
import 'package:traga_monedas/src/home/domain/entities/income_entity.dart';
import 'package:traga_monedas/src/home/domain/use_cases/get_incomes_use_case.dart';
import 'package:traga_monedas/src/home/ui/pages/add_income/add_income_page.dart';
import 'package:utils/utils.dart';

class HomeAllSlotController extends GetxController {
  DateTime? initialDay;
  DateTime? finalDay;
  GetIncomesUseCase getIncomesUseCase;
  List<IncomeEntity> incomes = [];
  bool validando = false;

  HomeAllSlotController({
    required this.getIncomesUseCase,
  });

  double get incomesInsert {
    return incomes.fold(0, (previous, current) => previous + (current.typeIncome == 'Ingreso' ? current.amount : defaultDouble));
  }

  double get incomesExit {
    return incomes.fold(0, (previous, current) => previous + (current.typeIncome == 'Salida' ? current.amount : defaultDouble));
  }

  double get gains {
    return incomesInsert - incomesExit;
  }

  @override
  void onInit() {
    initialDay =
        DateTime.now().subtract(Duration(days: (DateTime.now().weekday - 1)));
    finalDay = DateTime.now()
        .add(Duration(days: DateTime.daysPerWeek - DateTime.now().weekday));
    update([pageIdGet]);
    super.onInit();
  }

  @override
  void onReady() {
    getIncomes();
    super.onReady();
  }

  Future<void> getIncomes() async {
    validando = true;
    update([validandoIdGet]);
    ResultType<List<IncomeEntity>, ErrorEntity> resultType = await getIncomesUseCase.execute(
      pointMachineRequest: PointMachineRequest()
    );
    if(resultType is Success){
      List<IncomeEntity> results = resultType.data;
      incomes = results;
      update([pageIdGet]);
    }else{
      ErrorEntity errorEntity = resultType.error;
      showSnackbarWidget(
        context: Get.overlayContext!,
        typeSnackbar: TypeSnackbar.error,
        message: errorEntity.title,
      );
    }
    validando = false;
    update([validandoIdGet]);
  }

  void goAddIncome() async {
    IncomeEntity? result = await Get.to(() => const AddIncomePage(),
        binding: AddIncomeBinding());
    if(result != null){
      getIncomes();
    }
  }
}