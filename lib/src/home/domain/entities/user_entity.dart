// To parse this JSON data, do
//
//     final userEntity = userEntityFromJson(jsonString);

import 'dart:convert';

List<UserEntity> userEntityFromJson(String str) => List<UserEntity>.from(json.decode(str).map((x) => UserEntity.fromJson(x)));

String userEntityToJson(List<UserEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserEntity {
    int id;
    String email;
    String password;
    String firstName;
    String lastName;
    String phoneNumber;
    String? state;
    DateTime? createdAt;
    DateTime? updatedAt;

    UserEntity({
        required this.id,
        required this.email,
        required this.password,
        required this.firstName,
        required this.lastName,
        required this.phoneNumber,
        this.state,
        this.createdAt,
        this.updatedAt,
    });

    factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        state: json["state"],
        createdAt: DateTime.tryParse(json["createdAt"])?.toLocal(),
        updatedAt: DateTime.tryParse(json["updatedAt"])?.toLocal(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "state": state,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
