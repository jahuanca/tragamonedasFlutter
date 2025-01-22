// To parse this JSON data, do
//
//     final machineEntity = machineEntityFromJson(jsonString);

import 'dart:convert';

List<MachineEntity> machineEntityFromJson(String str) => List<MachineEntity>.from(json.decode(str).map((x) => MachineEntity.fromJson(x)));

String machineEntityToJson(List<MachineEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MachineEntity {
    int? id;
    String name;
    String description;
    String observation;
    DateTime purchaseDate;
    String currencyValue;
    String? image;
    String? state;
    DateTime? createdAt;
    DateTime? updatedAt;

    MachineEntity({
        this.id,
        required this.name,
        required this.description,
        required this.observation,
        required this.purchaseDate,
        required this.currencyValue,
        this.image,
        this.state,
        this.createdAt,
        this.updatedAt,
    });

    factory MachineEntity.fromJson(Map<String, dynamic> json) => MachineEntity(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        observation: json["observation"],
        purchaseDate: DateTime.parse(json["purchaseDate"]).toLocal(),
        currencyValue: json["currencyValue"],
        image: json["image"],
        state: json["state"],
        createdAt: DateTime.tryParse(json["createdAt"])?.toLocal(),
        updatedAt: DateTime.tryParse(json["updatedAt"])?.toLocal(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "observation": observation,
        "purchaseDate": purchaseDate.toIso8601String(),
        "currencyValue": currencyValue,
        "image": image,
        "state": state,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
