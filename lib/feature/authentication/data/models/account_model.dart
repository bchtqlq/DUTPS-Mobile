import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.camel, ignoreNullMembers: true, name: 'data')
class AccountModel {
  String? username;
  String? accessToken;
}
