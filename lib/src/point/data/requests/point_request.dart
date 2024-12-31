
const _hasPointMachineKey = 'hasPointMachine';

class PointRequest {
  bool? hasPointMachine;

  PointRequest({
    this.hasPointMachine,
  });

  Map<String, dynamic> toJson() =>{
    _hasPointMachineKey: hasPointMachine,
  };

  factory PointRequest.fromJson(Map<String, dynamic> json) => PointRequest(
    hasPointMachine: json[_hasPointMachineKey],
  );

}