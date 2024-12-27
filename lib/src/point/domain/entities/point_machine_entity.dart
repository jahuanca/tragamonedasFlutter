
import 'dart:convert';

import 'package:traga_monedas/src/machine/domain/entities/machine_entity.dart';
import 'package:traga_monedas/src/point/domain/entities/point_entity.dart';

List<PointMachineEntity> pointMachineEntityFromJsonList(String str) => List<PointMachineEntity>.from(
    json.decode(str).map((x) => PointMachineEntity.fromJson(x)));

String pointMachineEntityToJson(List<PointMachineEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

const _idKey = 'id';
const _idPointKey = 'idPoint';
const _idMachineKey = 'idMachine';
const _porcentageKey = 'porcentage';
const _pointEntityKey = 'Point';
const _machineEntityKey = 'Machine';

class PointMachineEntity {
  int? id;
  int idPoint;
  int idMachine;
  double porcentage;
  PointEntity? pointEntity;
  MachineEntity? machineEntity;

  PointMachineEntity({
    this.id,
    required this.idPoint,
    required this.idMachine,
    required this.porcentage,
    this.pointEntity,
    this.machineEntity,
  });

  Map<String, dynamic> toJson() => {
        _idKey: id,
        _idPointKey: idPoint,
        _idMachineKey: idMachine,
        _porcentageKey: porcentage,
        _pointEntityKey: pointEntity?.toJson(),
        _machineEntityKey: machineEntity?.toJson(),
      };

  factory PointMachineEntity.fromJson(Map<String, dynamic> json) =>
      PointMachineEntity(
        id: json[_idKey],
        idPoint: json[_idPointKey],
        idMachine: json[_idMachineKey],
        porcentage: (json[_porcentageKey] as num).toDouble(),
        pointEntity: json[_pointEntityKey] == null ? null : PointEntity.fromJson(json[_pointEntityKey]),
        machineEntity: json[_machineEntityKey] == null ? null : MachineEntity.fromJson(json[_machineEntityKey]),
      );
}
