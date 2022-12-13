import 'dart:convert';

import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.camel, ignoreNullMembers: true)
class CustomerModel {
  String? username;
  String? email;
  int? role;
  String? name;
  int? gender;
  DateTime? birthday;
  String? phoneNumber;
  @JsonProperty(name: 'class')
  String? activityClass;
  String? facultyId;
  String? falcultyName;
  List<dynamic>? vehicals;
  VehicalModel? vehical;

  CustomerModel({
    this.username,
    this.email,
    this.role,
    this.name,
    this.gender,
    this.birthday,
    this.phoneNumber,
    this.activityClass,
    this.facultyId,
    this.falcultyName,
    this.vehicals,
    this.vehical,
  });

  Map<String, dynamic> toJson() {
    return {
      '"username"': '"$username"',
      '"email"': '"$email"',
      '"role"': role,
      '"name"': '"${name ?? ""}"',
      '"gender"': gender ?? -1,
      '"birthday"': '"${birthday ?? DateTime(2022)}"',
      '"phoneNumber"': '"${phoneNumber ?? ""}"',
      '"activityClass"': '"${activityClass ?? ""}"',
      '"facultyId"': '"${facultyId ?? ""}"',
      '"falcultyName"': '"${falcultyName ?? ""}"',
      '"vehicals"': vehicals != null ? jsonEncode(vehicals!.map((e) => e).toList()) : List<VehicalModel>.empty(),
    };
  }

  Map<String, dynamic> toJsonWithVehical(VehicalModel vehicalModel) {
    return {
      '"username"': '"$username"',
      '"email"': '"$email"',
      '"role"': role,
      '"name"': '"${name ?? ""}"',
      '"gender"': gender ?? -1,
      '"birthday"': '"${birthday ?? DateTime(2022)}"',
      '"phoneNumber"': '"${phoneNumber ?? ""}"',
      '"activityClass"': '"${activityClass ?? ""}"',
      '"facultyId"': '"${facultyId ?? ""}"',
      '"falcultyName"': '"${falcultyName ?? ""}"',
      '"vehical"': vehicalModel.toJson(),
    };
  }

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      username: json['username'],
      email: json['email'],
      role: json['role'],
      name: json['name'],
      gender: json['gender'],
      birthday: DateTime.parse(json['birthday']),
      phoneNumber: json['phoneNumber'],
      activityClass: json['activityClass'],
      facultyId: json['facultyId'],
      falcultyName: json['falcultyName'],
      vehicals: List<VehicalModel>.from(json['vehicals'].map((model) => VehicalModel.fromJson(model))),
    );
  }

  factory CustomerModel.fromJsonWithVehical(Map<String, dynamic> json) {
    return CustomerModel(
      username: json['username'],
      email: json['email'],
      role: json['role'],
      name: json['name'],
      gender: json['gender'],
      birthday: DateTime.parse(json['birthday']),
      phoneNumber: json['phoneNumber'],
      activityClass: json['activityClass'],
      facultyId: json['facultyId'],
      falcultyName: json['falcultyName'],
      vehical: VehicalModel.fromJson(json['vehical']),
    );
  }
}

@jsonSerializable
@Json(caseStyle: CaseStyle.camel, ignoreNullMembers: true)
class VehicalModel {
  int? id;
  String? licensePlate;
  String? description;

  VehicalModel({this.id, this.licensePlate, this.description});

  Map<String, dynamic> toJson() {
    return {
      '"id"': id,
      '"licensePlate"': '"$licensePlate"',
      '"description"': '"$description"',
    };
  }

  factory VehicalModel.fromJson(Map<String, dynamic> json) {
    return VehicalModel(
      id: json['id'],
      licensePlate: json['licensePlate'],
      description: json['description'],
    );
  }
}
