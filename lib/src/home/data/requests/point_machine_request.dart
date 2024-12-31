const _idPointMachineKey = 'idPointMachine';
const _firstDateKey = 'firstDate';
const _lastDateKey = 'lastDate';

class IncomeRequest {
  int? idPointMachine;
  DateTime firstDate;
  DateTime lastDate;

  IncomeRequest({
    required this.firstDate,
    required this.lastDate,
    this.idPointMachine,
  });

  Map<String, dynamic> toJson() => {
        _firstDateKey: firstDate,
        _lastDateKey: lastDate,
        _idPointMachineKey: idPointMachine,
      };

  factory IncomeRequest.fromJson(Map<String, dynamic> json) =>
      IncomeRequest(
        firstDate: json[_firstDateKey],
        lastDate: json[_lastDateKey],
        idPointMachine: json[_idPointMachineKey]);
}
