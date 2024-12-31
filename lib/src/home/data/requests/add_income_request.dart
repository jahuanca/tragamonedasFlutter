
const _typeIncomeKey = 'typeIncome';
const _amountKey = 'amount';
const _porcentageKey = 'porcentage';
const _descriptionKey = 'description';
const _withPayForClientKey = 'withPayForClient';
const _idPointMachineKey = 'idPointMachine';
const _payForClientKey = 'payForClient';
const _dateKey = 'date';

class AddIncomeRequest {

  String typeIncome;
  double amount;
  double porcentage;
  bool? withPayForClient;
  double? payForClient;
  String? description;
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
  });

  Map<String, dynamic> toJson() => {
    _typeIncomeKey: typeIncome,
    _amountKey: amount,
    _porcentageKey: porcentage,
    _descriptionKey: description,
    _withPayForClientKey: withPayForClient,
    _idPointMachineKey: idPointMachine,
    _dateKey: date.toIso8601String(),
    _payForClientKey: payForClient,
  };

  factory AddIncomeRequest.fromJson(Map<String, dynamic> json) => AddIncomeRequest(
    typeIncome: json[_typeIncomeKey], 
    amount: json[_amountKey], 
    porcentage: json[_porcentageKey],
    description: json[_descriptionKey],
    withPayForClient: json[_withPayForClientKey],
    idPointMachine: json[_idPointMachineKey],
    payForClient: json[_payForClientKey],
    date: DateTime.parse(json[_dateKey]),
  );

}