import 'package:utils/utils.dart';

const _typeIncomeKey = 'typeIncome';
const _amountKey = 'amount';
const _porcentageKey = 'porcentage';
const _descriptionKey = 'description';
const _withPayForClientKey = 'withPayForClient';
const _idPointMachineKey = 'idPointMachine';
const _payForClientKey = 'payForClient';
const _payForATMKey = 'payForATM';
const _namePointKey = 'namePoint';
const _dateKey = 'date';

class AddIncomeRequest {
  String typeIncome;
  double amount;
  double porcentage;
  bool? withPayForClient;
  double? payForClient;
  double? payForATM;
  String? description;
  String? namePoint;
  int idPointMachine;
  DateTime date;

  AddIncomeRequest({
    required this.date,
    required this.typeIncome,
    required this.amount,
    required this.porcentage,
    required this.idPointMachine,
    this.withPayForClient,
    this.description,
    this.payForClient,
    this.payForATM,
    this.namePoint,
  });

  String get messageIfSuccess {
    String dateFormat =
        date.format(formatDate: 'EEEE d/MM hh:mm a') ?? emptyString;
    if (typeIncome == 'Ingreso') {
      if (withPayForClient.orFalse()) {
        return '$namePoint $dateFormat: (${porcentage.formatDecimals()}%) Se ingreso ${amount.formatDecimals()}, se canceló al cliente ${payForClient?.formatDecimals()} y para caja: ${payForATM?.formatDecimals()}.';
      } else {
        return '$namePoint $dateFormat: (${porcentage.formatDecimals()}%) Se ingreso ${amount.formatDecimals()}, será para el cliente ${payForClient?.formatDecimals()} y para caja: ${payForATM?.formatDecimals()}.';
      }
    } else {
      return '$namePoint $dateFormat: Se retiró ${amount.formatDecimals()}, motivo: $description.';
    }
  }

  Map<String, dynamic> toJson() => {
        _typeIncomeKey: typeIncome,
        _amountKey: amount,
        _porcentageKey: porcentage,
        _descriptionKey: description,
        _withPayForClientKey: withPayForClient,
        _idPointMachineKey: idPointMachine,
        _dateKey: date.toIso8601String(),
        _payForClientKey: payForClient,
        _payForATMKey: payForATM,
        _namePointKey: namePoint,
      };

  factory AddIncomeRequest.fromJson(Map<String, dynamic> json) =>
      AddIncomeRequest(
        typeIncome: json[_typeIncomeKey],
        amount: json[_amountKey],
        porcentage: json[_porcentageKey],
        description: json[_descriptionKey],
        withPayForClient: json[_withPayForClientKey],
        idPointMachine: json[_idPointMachineKey],
        payForClient: json[_payForClientKey],
        payForATM: json[_payForATMKey],
        namePoint: json[_namePointKey],
        date: DateTime.parse(json[_dateKey]),
      );
}
