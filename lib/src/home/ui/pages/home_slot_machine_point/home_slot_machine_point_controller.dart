import 'package:get/get.dart';
import 'package:traga_monedas/src/home/di/add_income_binding.dart';
import 'package:traga_monedas/src/home/domain/entities/income_entity.dart';
import 'package:traga_monedas/src/home/domain/use_cases/get_incomes_use_case.dart';
import 'package:traga_monedas/src/home/ui/pages/add_income/add_income_page.dart';
import 'package:traga_monedas/src/point/domain/entities/point_machine_entity.dart';
import 'package:traga_monedas/src/utils/ui/arguments.dart';
import 'package:utils/utils.dart';

class HomeSlotMachinePointController extends GetxController {
  DateTime? initialDay;
  DateTime? finalDay;
  PointMachineEntity? pointMachineEntity;
  GetIncomesUseCase getIncomesUseCase;
  List<IncomeEntity> incomes = [];
  bool validando = false;

  HomeSlotMachinePointController({
    required this.getIncomesUseCase,
  });

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments[pointMachineSelectedArgument] != null) {
        pointMachineEntity =
            Get.arguments[pointMachineSelectedArgument] as PointMachineEntity;
      }
    }

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

  void getIncomes() async {
    validando = false;
    update([validandoIdGet]);
    ResultType<List<IncomeEntity>, ErrorEntity> resultType = await getIncomesUseCase.execute();
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
    validando = true;
    update([validandoIdGet]);
  }

  void goAddIncome() async {
    IncomeEntity? result = await Get.to(() => const AddIncomePage(),
        arguments: {
          pointMachineArgument: pointMachineEntity,
        },
        binding: AddIncomeBinding());
    if(result != null){
      getIncomes();
    }
  }
}
