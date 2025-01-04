import 'package:get/get.dart';
import 'package:traga_monedas/src/point/domain/entities/point_entity.dart';
import 'package:traga_monedas/src/point/domain/use_cases/create_point_use_case.dart';
import 'package:traga_monedas/src/utils/ui/arguments.dart';
import 'package:traga_monedas/src/utils/ui/ids_get.dart';
import 'package:traga_monedas/src/utils/ui/utils.dart';
import 'package:traga_monedas/src/utils/ui/validators.dart';
import 'package:utils/utils.dart';

class AddPointControlller extends GetxController {
  String? errorFirstName,
      errorLastName,
      errorPhoneNumber,
      errorEmail,
      errorPorcentage,
      errorAlias,
      errorAddress;

  String? firstName, lastName, phoneNumber, email, porcentage, alias, address;
  bool? payWeekly;

  bool editing = false;
  String titlePage = emptyString;

  final CreatePointUseCase createPointUseCase;

  bool validando = false;

  AddPointControlller({
    required this.createPointUseCase,
  });

  @override
  void onInit() {
    PointEntity? pointEntity = Get.setArguments(pointEntityArgument);
    if (pointEntity != null) {
      editing = true;
      firstName = pointEntity.firstName;
      lastName = pointEntity.lastName;
      phoneNumber = pointEntity.phoneNumber;
      email = pointEntity.email;
      porcentage = pointEntity.porcentage.formatDecimals();
      payWeekly = pointEntity.payWeekly;
      alias = pointEntity.alias;
      address = pointEntity.address;
      titlePage = 'Editar cliente';
    } else {
      titlePage = 'Agregar cliente';
    }
    super.onInit();
  }

  void onChangedName(String value) {
    ValidateResult validateName =
        validateRequired(label: 'Nombre', value: value);
    errorFirstName = validateName.error;
    firstName = validateName.value;
    update([nameIdGet]);
  }

  void onChangedLastName(String value) {
    ValidateResult validateLastName =
        validateRequired(label: 'Apellido', value: value);
    errorLastName = validateLastName.error;
    lastName = validateLastName.value;
    update([lastNameIdGet]);
  }

  void onChangedPhoneNumber(String value) {
    ValidateResult validatePhoneNumber =
        validateRequired(label: 'Teléfono', value: value);
    errorPhoneNumber = validatePhoneNumber.error;
    phoneNumber = validatePhoneNumber.value;
    update([phoneNumberIdGet]);
  }

  void onChangedEmail(String value) {
    ValidateResult validateEmail =
        validateRequired(label: 'Email', value: value);
    errorEmail = validateEmail.error;
    email = validateEmail.value;
    update([emailIdGet]);
  }

  void onChangedPorcentage(String value) {
    ValidateResult validatePorcentage =
        validateRequired(label: 'Porcentaje', value: value);
    errorPorcentage = validatePorcentage.error;
    porcentage = validatePorcentage.value;
    update([porcentageIdGet]);
  }

  void onChangePayWeekly(bool? value) {
    payWeekly = value;
    update([payWeeklyIdGet]);
  }

  void onChangedAlias(String value) {
    ValidateResult validateAlias =
        validateRequired(label: 'Alias', value: value);
    errorAlias = validateAlias.error;
    alias = validateAlias.value;
    update([aliasIdGet]);
  }

  void onChangedAddress(String value) {
    ValidateResult validateAddress =
        validateRequired(label: 'Alias', value: value);
    errorAddress = validateAddress.error;
    address = validateAddress.value;
    update([aliasIdGet]);
  }

  String? validar() {
    onChangedName(firstName.orEmpty());
    onChangedLastName(lastName.orEmpty());
    onChangedPhoneNumber(phoneNumber.orEmpty());
    onChangedEmail(email.orEmpty());
    onChangedPorcentage(porcentage.orEmpty());
    onChangedAlias(alias.orEmpty());
    onChangedAddress(address.orEmpty());

    return [
      errorFirstName,
      errorLastName,
      errorPhoneNumber,
      errorEmail,
      errorPorcentage,
      errorAlias,
      errorAddress,
    ].firstWhereOrNull(
      (e) => e != null,
    );
  }

  void createPoint() async {
    String? message = validar();
    if (validar() != null) {
      _showSnackbarWidgetError(message: message);
      return;
    }
    validando = true;
    update([validandoIdGet]);
    if (editing) {
    } else {
      ResultType<PointEntity, ErrorEntity> resultType =
          await createPointUseCase.execute(
              pointEntity: PointEntity(
        firstName: firstName.orEmpty(),
        lastName: lastName.orEmpty(),
        alias: alias.orEmpty(),
        address: address.orEmpty(),
        phoneNumber: phoneNumber.orEmpty(),
        email: email.orEmpty(),
        payWeekly: payWeekly.orFalse(),
        porcentage: double.parse(porcentage.orEmpty()),
      ));
      if (resultType is Success) {
        PointEntity pointEntity = resultType.data;
        Get.back(result: pointEntity);
      } else {
        ErrorEntity errorEntity = resultType.error as ErrorEntity;
        _showSnackbarWidgetError(message: errorEntity.title);
      }
      validando = false;
      update([validandoIdGet]);
    }
  }

  void _showSnackbarWidgetError({
    required message,
  }) {
    showSnackbarWidget(
      context: Get.overlayContext!,
      typeSnackbar: TypeSnackbar.error,
      message: message,
    );
  }
}
