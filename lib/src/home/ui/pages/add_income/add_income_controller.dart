import 'package:get/get.dart';
import 'package:traga_monedas/src/home/data/requests/add_income_request.dart';
import 'package:traga_monedas/src/home/domain/entities/income_entity.dart';
import 'package:traga_monedas/src/home/domain/use_cases/create_income_use_case.dart';
import 'package:traga_monedas/src/home/domain/use_cases/get_types_income_use_case.dart';
import 'package:traga_monedas/src/point/domain/entities/point_machine_entity.dart';
import 'package:traga_monedas/src/utils/ui/arguments.dart';
import 'package:traga_monedas/src/utils/ui/ids_get.dart';
import 'package:traga_monedas/src/utils/ui/validators.dart';
import 'package:utils/utils.dart';

class AddIncomeController extends GetxController {
  double forClient = defaultDouble;
  double forATM = defaultDouble;

  double? porcentage;
  bool? withPayForClient;
  double? amount;
  String? description;
  String typeIncome = 'Ingreso de dinero';

  PointMachineEntity? pointMachineEntity;
  GetTypesIncomeUseCase getTypesIncomeUseCase;
  CreateIncomeUseCase createIncomeUseCase;
  List<String> typesIncome = [];
  String typeIncomeInsert = 'Ingreso';
  bool validando = false;
  String? errorAmount, errorTypeIncome, errorDescription;

  AddIncomeController({
    required this.getTypesIncomeUseCase,
    required this.createIncomeUseCase,
  });

  //todo: al final que backend se encargue de crear dos en caso de que el pago del cliente este en true.

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments[pointMachineArgument] != null) {
        pointMachineEntity = Get.arguments[pointMachineArgument];
        porcentage = pointMachineEntity?.porcentage ?? defaultDouble;
      }
    }
    super.onInit();
  }

  @override
  void onReady() {
    getTypesIncome();
    super.onReady();
  }

  void getTypesIncome() async {
    validando = true;
    update([validandoIdGet]);
    ResultType<List<String>, ErrorEntity> resultType =
        await getTypesIncomeUseCase.execute();
    if (resultType is Success) {
      List<String> results = resultType.data as List<String>;
      typesIncome = results;
      onChangedTypeIncome(typeIncomeInsert);
      update([typeIncomeIdGet]);
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

  void onChangeMonto(String value) {
    ValidateResult result = validateText(rules: {
      RuleValidator.isRequired: true,
      RuleValidator.isDouble: true,
    }, text: value, label: 'Monto');

    if (result.error == null) {
      amount = double.parse(value);
      errorAmount = null;
      forClient = amount.orZero() * 0.25;
      forATM = amount.orZero() * 0.75;
    } else {
      errorAmount = result.error;
      amount = null;
      forClient = defaultDouble;
      forATM = defaultDouble;
    }
    update([forClientIdGet, forATMIdGet]);
  }

  void onChangedTypeIncome(dynamic value) {
    typeIncome = value;
    ValidateResult resultValidate =
        validateRequired(label: 'Tipo de movimiento', value: value);
    if (resultValidate.error != null) {
      errorTypeIncome = resultValidate.error;
    } else {
      typeIncome = resultValidate.value.orEmpty();
    }
    update([pageIdGet]);
  }

  void onChangeWithPayClient(bool? value) {
    withPayForClient = value;
    update([withPayForClientIdGet]);
  }

  void onChangeDescription(String? value) {
    if(typeIncome != typeIncomeInsert){
      ValidateResult validateResult = validateText(
        text: value, label: 'Descripción',
        rules: {
          RuleValidator.isRequired: true,
        }
      );
      errorDescription = validateResult.error;
      description = validateResult.value;
    }else{
      description = null;
    }
    update([descriptionIdGet]);
  }

  String? validar() {
    onChangedTypeIncome(typeIncome.orEmpty());
    onChangeMonto(amount.orZero().toString());
    onChangeDescription(description);
    return [
      errorTypeIncome,
      errorAmount,
      errorDescription,
    ].firstWhereOrNull(
      (e) => e != null,
    );
  }

  void createIncome() async {
    String? message = validar();
    if (message != null) {
      showSnackbarWidget(
          context: Get.overlayContext!,
          typeSnackbar: TypeSnackbar.error,
          message: message);
      return;
    }
    validando = true;
    update([validandoIdGet]);
    ResultType<IncomeEntity, ErrorEntity> resultType =
        await createIncomeUseCase.execute(AddIncomeRequest(
            typeIncome: typeIncome,
            amount: amount.orZero(),
            porcentage: porcentage.orZero(),
            withPayForClient: withPayForClient,
            description: description,
            payForClient: forClient,
            idPointMachine: pointMachineEntity?.id ?? defaultInt));

    if (resultType is Success) {
      IncomeEntity result= resultType.data as IncomeEntity;
      Get.back(result: result);
    } else {
      showSnackbarWidget(
        context: Get.overlayContext!,
        typeSnackbar: TypeSnackbar.error,
        message: resultType.error.title,
      );
    }
    validando = false;
    update([validandoIdGet]);
  }
}
