import 'package:get/get.dart';
import 'package:traga_monedas/src/machine/domain/entities/machine_entity.dart';
import 'package:traga_monedas/src/machine/domain/use_cases/create_machine_use_case.dart';
import 'package:traga_monedas/src/machine/domain/use_cases/get_currency_values_use_case.dart';
import 'package:traga_monedas/src/utils/ui/ids_get.dart';
import 'package:traga_monedas/src/utils/ui/validators.dart';
import 'package:utils/utils.dart';

class AddMachineController extends GetxController {
  String? errorName,
      errorDescription,
      errorObservation,
      errorPuchaseDate,
      errorCurrencyValue;
  String? name, description, observation, currencyValue;
  DateTime? purchaseDate;
  MachineEntity? machineEntity;
  List<String> currencyValues = [];
  bool validando = false;

  CreateMachineUseCase createMachineUseCase;
  GetCurrencyValuesUseCase getCurrencyValuesUseCase;

  AddMachineController({
    required this.createMachineUseCase,
    required this.getCurrencyValuesUseCase,
  });

  @override
  void onReady() {
    getCurrencyValues();
    super.onReady();
  }

  void getCurrencyValues() async {
    validando = true;
    update([validandoIdGet]);
    ResultType<List<String>, ErrorEntity> resultType =
        await getCurrencyValuesUseCase.execute();
    if (resultType is Success) {
      currencyValues = resultType.data;
    } else {
      ErrorEntity errorEntity = resultType.error as ErrorEntity;
      showSnackbarWidget(
          context: Get.overlayContext!,
          typeSnackbar: TypeSnackbar.error,
          message: errorEntity.title);
    }
    validando = false;
    update([validandoIdGet, currencyValuesIdGet]);
  }

  void onChangedName(String value) {
    ValidateResult validateName =
        validateRequired(label: 'Nombre', value: value);
    errorName = validateName.error;
    name = validateName.value;
    update([nameIdGet]);
  }

  void onChangedDescription(String value) {
    ValidateResult validateDescription =
        validateRequired(label: 'Descripción', value: value);
    errorDescription = validateDescription.error;
    description = validateDescription.value;
    update([descriptionIdGet]);
  }

  void onChangedObservation(String value) {
    observation = value;
  }

  void onChangeCurrencyValue(String value) {
    currencyValue = value;
  }

  void onChangedPurchaseDate(DateTime? value) {
    ValidateResult validatePurchaseDate =
        validateRequired(label: 'Fecha de compra', value: value);
    errorPuchaseDate = validatePurchaseDate.error;
    purchaseDate = DateTime.tryParse(validatePurchaseDate.value.orEmpty());
    update([purchaseDateIdGet]);
  }

  void onChangedCurrencyValues(String value) {
    ValidateResult validateCurrencyValue = validateText(
        text: value.toString(),
        label: 'Valor de la moneda',
        rules: {
          RuleValidator.isRequired: true,
        });
    errorCurrencyValue = validateCurrencyValue.error;
    currencyValue = validateCurrencyValue.value;
    update([currencyValuesIdGet]);
  }

  String? _validar() {
    onChangedName(name.orEmpty());
    onChangedDescription(description.orEmpty());
    onChangedPurchaseDate(purchaseDate);
    return [
      errorName,
      errorDescription,
      errorPuchaseDate,
    ].firstWhereOrNull(
      (e) => e != null,
    );
  }

  void createMachine() async {
    String? message = _validar();
    if (message == null) {
      validando = true;
      update([validandoIdGet]);
      ResultType<MachineEntity, ErrorEntity> resultType =
          await createMachineUseCase.execute(
              machine: MachineEntity(
                  name: name.orEmpty(),
                  description: description.orEmpty(),
                  observation: observation.orEmpty(),
                  purchaseDate: purchaseDate!,
                  currencyValue: currencyValue.orEmpty()));
      if (resultType is Success) {
        MachineEntity machineEntity = resultType.data as MachineEntity;
        Get.back(result: machineEntity);
      } else {
        ErrorEntity errorEntity = resultType.error as ErrorEntity;
        showSnackbarWidget(
            context: Get.overlayContext!,
            typeSnackbar: TypeSnackbar.error,
            message: errorEntity.title);
      }
      validando = false;
      update([validandoIdGet]);
    } else {
      showSnackbarWidget(
          context: Get.overlayContext!,
          typeSnackbar: TypeSnackbar.error,
          message: message);
    }
  }
}
