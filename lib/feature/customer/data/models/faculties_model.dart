import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.camel, ignoreNullMembers: true)
class FacultyModel {
  String? id;
  String? name;

  FacultyModel({this.id, this.name});

  Map<String, dynamic> toJson() {
    return {
      '"id"': '"$id"',
      '"name"': '"$name"',
    };
  }

  factory FacultyModel.fromJson(Map<String, dynamic> json) {
    return FacultyModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
