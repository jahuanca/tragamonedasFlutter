
const _hasPointMachineKey = 'hasPointMachine';

class MachineRequest {
  bool? hasPointMachine;

  MachineRequest({
    this.hasPointMachine,
  });

  Map<String, dynamic> toJson() =>{
    _hasPointMachineKey: hasPointMachine,
  };

  factory MachineRequest.fromJson(Map<String, dynamic> json) => MachineRequest(
    hasPointMachine: json[_hasPointMachineKey],
  );

}