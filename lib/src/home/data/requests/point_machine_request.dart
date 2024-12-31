const _idPointMachineKey = 'idPointMachine';

class PointMachineRequest {
  int? idPointMachine;

  PointMachineRequest({
    this.idPointMachine,
  });

  Map<String, dynamic> toJson() => {
        _idPointMachineKey: idPointMachine,
      };

  factory PointMachineRequest.fromJson(Map<String, dynamic> json) =>
      PointMachineRequest(idPointMachine: json[_idPointMachineKey]);
}
