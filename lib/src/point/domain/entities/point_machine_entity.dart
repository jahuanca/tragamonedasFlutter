
import 'dart:convert';

List<PointMachineEntity> pointMachineEntityFromJsonList(String str) => List<PointMachineEntity>.from(
    json.decode(str).map((x) => PointMachineEntity.fromJson(x)));

String pointMachineEntityToJson(List<PointMachineEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

const _idPointKey = 'idPoint';
const _idMachineKey = 'idMachine';
const _porcentageKey = 'porcentage';

class PointMachineEntity {
  int idPoint;
  int idMachine;
  double porcentage;

  PointMachineEntity({
    required this.idPoint,
    required this.idMachine,
    required this.porcentage,
  });

  Map<String, dynamic> toJson() => {
        _idPointKey: idPoint,
        _idMachineKey: idMachine,
        _porcentageKey: porcentage,
      };

  factory PointMachineEntity.fromJson(Map<String, dynamic> json) =>
      PointMachineEntity(
        idPoint: json[_idPointKey],
        idMachine: json[_idMachineKey],
        porcentage: (json[_porcentageKey] as num).toDouble(),
      );
}
