import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traga_monedas/src/home/data/requests/incomes_request.dart';
import 'package:traga_monedas/src/home/di/add_income_binding.dart';
import 'package:traga_monedas/src/home/domain/entities/income_entity.dart';
import 'package:traga_monedas/src/home/domain/use_cases/get_incomes_use_case.dart';
import 'package:traga_monedas/src/home/ui/pages/add_income/add_income_page.dart';
import 'package:traga_monedas/src/home/ui/pages/home_slot/options_menu.dart';
import 'package:traga_monedas/src/point/domain/entities/point_machine_entity.dart';
import 'package:traga_monedas/src/utils/core/enum_type_page.dart';
import 'package:traga_monedas/src/utils/core/helpers.dart';
import 'package:traga_monedas/src/utils/ui/arguments.dart';
import 'package:utils/utils.dart';

class HomeSlotController extends GetxController {
  DateTime? initialDay;
  DateTime? finalDay;
  PointMachineEntity? pointMachineEntity;
  GetIncomesUseCase getIncomesUseCase;
  List<IncomeEntity> incomes = [];
  bool validando = false;
  EnumTypePage typePage = EnumTypePage.normal;
  List<IncomeEntity> idsSelecteds = [];

  HomeSlotController({
    required this.getIncomesUseCase,
  });

  double get incomesInsert {
    return incomes.fold(
        defaultDouble,
        (previous, current) =>
            previous +
            (current.typeIncome == 'Ingreso' ? current.amount : defaultDouble));
  }

  double get incomesExit {
    return incomes.fold(
        defaultDouble,
        (previous, current) =>
            previous +
            (current.typeIncome == 'Salida' ? current.amount : defaultDouble));
  }

  double get gains {
    return incomesInsert - incomesExit;
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments[pointMachineSelectedArgument] != null) {
        pointMachineEntity =
            Get.arguments[pointMachineSelectedArgument] as PointMachineEntity;
      }
    }

    initialDay =
        DateTime.now().subtract(Duration(days: (defaultDate.weekday - 1)));
    finalDay = DateTime.now()
        .add(Duration(days: DateTime.daysPerWeek - defaultDate.weekday));
    update([pageIdGet]);
    super.onInit();
  }

  @override
  void onReady() {
    getIncomes();
    super.onReady();
  }

  void onChangeRange(DateTimeRange? range) {
    if (range != null) {
      initialDay = range.start;
      finalDay = range.end;
      getIncomes();
    }
  }

  Future<void> getIncomes() async {
    validando = true;
    update([validandoIdGet]);
    ResultType<List<IncomeEntity>, ErrorEntity> resultType =
        await getIncomesUseCase.execute(
            pointMachineRequest: IncomesRequest(
                includeModels: false,
                firstDate: initialDay.orNow(),
                lastDate: finalDay.orNow(),
                idPointMachine: pointMachineEntity?.id));
    if (resultType is Success) {
      List<IncomeEntity> results = resultType.data;
      incomes = results;
      update([pageIdGet]);
    } else {
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
        arguments: {
          pointMachineArgument: pointMachineEntity,
        },
        binding: AddIncomeBinding());
    if (result != null) {
      getIncomes();
    }
  }

  void goSelectedItem(IncomeEntity selected) {
    int index = idsSelecteds.indexWhere(
      (e) => e.id == selected.id,
    );
    if (index == notFoundPosition) {
      idsSelecteds.add(selected);
    } else {
      idsSelecteds.removeAt(index);
    }
    update(['item_${selected.id}', pageIdGet]);
    if (idsSelecteds.isEmpty) {
      typePage = EnumTypePage.normal;
      update([pageIdGet]);
    }
  }

  void onChangeView(IncomeEntity selected) {
    typePage = EnumTypePage.selection;
    goSelectedItem(selected);
    update([pageIdGet]);
  }

  void resetView() {
    idsSelecteds.clear();
    typePage = EnumTypePage.normal;
    update([pageIdGet]);
  }

  void selectAll() {
    idsSelecteds.clear();
    for (IncomeEntity income in incomes) {
      if (income.id == null) continue;
      idsSelecteds.add(income);
    }
    update([pageIdGet]);
  }

  void unselectAll() {
    idsSelecteds.clear();
    update([pageIdGet]);
  }

  void onTapItem(OptionsMenuSelection option) {
    switch (option) {
      case OptionsMenuSelection.share:
        break;
      case OptionsMenuSelection.delete:
        break;
      case OptionsMenuSelection.copy:
        copyData('');
        break;
      default:
        break;
    }
  }

  void onTapReport(dynamic option) {
    switch (option as OptionsMenuReport) {
      case OptionsMenuReport.all:
        List<String> summarys = incomes
            .map(
              (e) => e.summary,
            )
            .toList();
        String message =
            '${initialDay.formatDMMYYY()} - ${finalDay.formatDMMYYY()}\nTotal: $incomesInsert soles.\nPagos (${pointMachineEntity?.porcentage.formatDecimals()}%): $incomesExit soles. \nGanancia: ${(incomesInsert-incomesExit).formatDecimals()} soles.';
        String allString = '${summarys.reversed.join('\n')} \n $message';
        copyData(allString);

        break;
      case OptionsMenuReport.summary:
        String message =
            '${initialDay.formatDMMYYY()} - ${finalDay.formatDMMYYY()}\nTotal: $incomesInsert soles.\nPagos (${pointMachineEntity?.porcentage.formatDecimals()}%): $incomesExit soles. \nGanancia: ${(incomesInsert-incomesExit).formatDecimals()} soles.';
        copyData(message);
        break;
      default:
        break;
    }
  }
}
