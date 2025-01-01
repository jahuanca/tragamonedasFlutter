const _idPointMachineKey = 'idPointMachine';
const _firstDateKey = 'firstDate';
const _lastDateKey = 'lastDate';
const _includeModelsKey = 'includeModels';

class IncomesRequest {
  int? idPointMachine;
  DateTime firstDate;
  bool includeModels;
  DateTime lastDate;

  IncomesRequest({
    required this.firstDate,
    required this.lastDate,
    required this.includeModels,
    this.idPointMachine,
  });

  Map<String, dynamic> toJson() => {
        _firstDateKey: firstDate,
        _lastDateKey: lastDate,
        _idPointMachineKey: idPointMachine,
        _includeModelsKey: includeModels,
      };

  factory IncomesRequest.fromJson(Map<String, dynamic> json) =>
      IncomesRequest(
        firstDate: json[_firstDateKey],
        lastDate: json[_lastDateKey],
        includeModels: json[_includeModelsKey],
        idPointMachine: json[_idPointMachineKey]);
}
