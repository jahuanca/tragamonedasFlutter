// To parse this JSON data, do
//
//     final incomeEntity = incomeEntityFromJson(jsonString);

import 'dart:convert';

import 'package:traga_monedas/src/point/domain/entities/point_machine_entity.dart';

List<IncomeEntity> incomeEntityFromJson(String str) => List<IncomeEntity>.from(
    json.decode(str).map((x) => IncomeEntity.fromJson(x)));

String incomeEntityToJson(List<IncomeEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IncomeEntity {
  int? id;
  String description;
  DateTime? date;
  double amount;
  String typeIncome;
  bool? isApproved;
  String state;
  DateTime createdAt;
  DateTime updatedAt;
  int? idUser;
  int idPointMachine;
  PointMachineEntity? pointMachineEntity;

  IncomeEntity({
    required this.id,
    required this.description,
    required this.date,
    required this.amount,
    required this.typeIncome,
    required this.isApproved,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
    required this.idUser,
    required this.idPointMachine,
    this.pointMachineEntity,
  });

  factory IncomeEntity.fromJson(Map<String, dynamic> json) => IncomeEntity(
        id: json["id"],
        description: json["description"],
        date: DateTime.parse(json["date"]),
        amount: (json["amount"] as num).toDouble(),
        typeIncome: json["typeIncome"],
        isApproved: json["isApproved"],
        state: json["state"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        idUser: json["idUser"],
        idPointMachine: json["idPointMachine"],
        pointMachineEntity: json["PointMachine"] == null
            ? null
            : PointMachineEntity.fromJson(json["PointMachine"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "date": date?.toIso8601String(),
        "amount": amount,
        "typeIncome": typeIncome,
        "isApproved": isApproved,
        "state": state,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "idUser": idUser,
        "idPointMachine": idPointMachine,
        "PointMachine": pointMachineEntity?.toJson(),
      };
}
