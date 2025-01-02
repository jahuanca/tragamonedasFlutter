import 'package:another_telephony/telephony.dart';
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

  late double porcentage;
  bool? withPayForClient;
  double? amount;
  DateTime? date;
  String? description;
  String typeIncome = 'Ingreso de dinero';

  PointMachineEntity? pointMachineEntity;
  GetTypesIncomeUseCase getTypesIncomeUseCase;
  CreateIncomeUseCase createIncomeUseCase;
  List<String> typesIncome = [];
  String typeIncomeInsert = 'Ingreso';
  bool validando = false;
  String? errorAmount, errorTypeIncome, errorDescription, errorDate;

  AddIncomeController({
    required this.getTypesIncomeUseCase,
    required this.createIncomeUseCase,
  });

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments[pointMachineArgument] != null) {
        pointMachineEntity = Get.arguments[pointMachineArgument];
        porcentage = pointMachineEntity?.porcentage ?? defaultDouble;
        withPayForClient =
            !(pointMachineEntity?.pointEntity?.payWeekly ?? false);
      }
    }
    super.onInit();
  }

  @override
  void onReady() {
    getTypesIncome();
    onChangeDate(defaultDate);
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

  void onChangeDate(DateTime? value) {
    ValidateResult resultType =
        validateText(text: value?.toString(), label: 'Fecha');
    if (resultType.hasError) {
      errorDate = resultType.error;
    } else {
      date = value;
    }
    update([dateIdGet]);
  }

  void onChangeMonto(String value) {
    ValidateResult result = validateText(rules: {
      RuleValidator.isRequired: true,
      RuleValidator.isDouble: true,
    }, text: value, label: 'Monto');

    if (result.error == null) {
      amount = double.parse(value);
      errorAmount = null;
      forClient = amount.orZero() * (porcentage.orZero()) / 100;
      forATM = amount.orZero() * (100 - porcentage.orZero()) / 100;
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
    if (typeIncome != typeIncomeInsert) {
      ValidateResult validateResult =
          validateText(text: value, label: 'Descripción', rules: {
        RuleValidator.isRequired: true,
      });
      errorDescription = validateResult.error;
      description = validateResult.value;
    } else {
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

    bool? result = await showDialogWidget(
      context: Get.overlayContext!, 
      message: '¿Está seguro de realizar este registro?');

    if(result.orFalse() == false) return;

    validando = true;
    update([validandoIdGet]);
    AddIncomeRequest addIncomeRequest = AddIncomeRequest(
        typeIncome: typeIncome,
        date: date.orNow(),
        amount: amount.orZero(),
        porcentage: porcentage.orZero(),
        withPayForClient: withPayForClient,
        description: description,
        payForClient: forClient,
        payForATM: forATM,
        namePoint: pointMachineEntity?.pointEntity?.aliasAndName ?? 'No name',
        idPointMachine: pointMachineEntity?.id ?? defaultInt);
    ResultType<IncomeEntity, ErrorEntity> resultType =
        await createIncomeUseCase.execute(addIncomeRequest: addIncomeRequest);

    if (resultType is Success) {
      IncomeEntity result = resultType.data as IncomeEntity;
      await _sendSMS2(
          message: addIncomeRequest.messageIfSuccess,
          recipients: ['+51936872966', '+51969645002']);
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

  Future<void> _sendSMS2(
      {required String message, required List<String> recipients}) async {
    final Telephony telephony = Telephony.instance;
    //+51951675718
    //+51936872966
    await telephony.sendSms(to: "+51936872966", message: message, isMultipart: true);
  }

}
