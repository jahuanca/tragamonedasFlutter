import 'dart:convert';

List<PointEntity> pointEntityFromJsonList(String str) => List<PointEntity>.from(
    json.decode(str).map((x) => PointEntity.fromJson(x)));

String pointEntityToJson(List<PointEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

const String _idKey = 'id';
const _firstNameKey = 'firstName';
const _lastNameKey = 'lastName';
const _aliasKey = 'alias';
const _addressKey = 'address';
const _latitudeKey = 'latitude';
const _longitudeKey = 'longitude';
const _phoneNumberKey = 'phoneNumber';
const _emailKey = 'email';
const _porcentageKey = 'porcentage';
const _createdAtKey = 'createdAt';
const _updatedAtKey = 'updatedAt';

class PointEntity {
  int? id;
  String firstName;
  String lastName;
  String alias;
  String address;
  String? latitude;
  String? longitude;
  String phoneNumber;
  String email;
  double porcentage;
  DateTime? createdAt;
  DateTime? updatedAt;

  PointEntity({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.alias,
    required this.address,
    this.latitude,
    this.longitude,
    required this.phoneNumber,
    required this.email,
    required this.porcentage,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
_idKey: id,
        _firstNameKey: firstName,
        _lastNameKey: lastName,
        _aliasKey: alias,
        _addressKey: address,
        _latitudeKey: latitude,
        _longitudeKey: longitude,
        _phoneNumberKey: phoneNumber,
        _emailKey: email,
        _porcentageKey: porcentage,
        _createdAtKey: createdAt?.toIso8601String(),
        _updatedAtKey: updatedAt?.toIso8601String(),
      };

  factory PointEntity.fromJson(Map<String, dynamic> json) => PointEntity(
        id: json[_idKey],
        firstName: json[_firstNameKey],
        lastName: json[_lastNameKey],
        alias: json[_aliasKey],
        address: json[_addressKey],
        phoneNumber: json[_phoneNumberKey],
        email: json[_emailKey],
        porcentage: (json[_porcentageKey] as num).toDouble() ,
        latitude: json[_latitudeKey],
        longitude: json[_longitudeKey],
        createdAt: DateTime.tryParse(json[_createdAtKey]),
        updatedAt: DateTime.tryParse(json[_updatedAtKey]),
      );
}
