import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.camel, ignoreNullMembers: true, name: 'data')
class AccountModel {
  String? username;
  String? accessToken;
  int? roleId;

  AccountModel({this.username, this.accessToken, this.roleId});

  Map<String, dynamic> toJson() {
    return {
      '"username"': '"$username"',
      '"accessToken"': '"$accessToken"',
      '"roleId"': roleId,
    };
  }

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      username: json['username'],
      accessToken: json['accessToken'],
      roleId: json['roleId'],
    );
  }
}
