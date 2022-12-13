import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.camel, ignoreNullMembers: true)
class CheckInModel {
  int? id;
  int? staffId;
  int? customerId;
  int? vehicalId;
  String? staffName;
  String? customerName;
  String? vehicalLicensePlate;
  String? vehicalDescription;
  bool? isCheckOut;
  DateTime? dateOfCheckIn;

  CheckInModel({
    this.id,
    this.staffId,
    this.customerId,
    this.vehicalId,
    this.staffName,
    this.customerName,
    this.vehicalLicensePlate,
    this.vehicalDescription,
    this.isCheckOut,
    this.dateOfCheckIn,
  });

  Map<String, dynamic> toJson() {
    return {
      '"id"': id,
      '"staffId"': staffId,
      '"customerId"': customerId,
      '"vehicalId"': vehicalId,
      '"staffName"': '"${staffName ?? ""}"',
      '"customerName"': '"${customerName ?? ""}"',
      '"vehicalLicensePlate"': '"${vehicalLicensePlate ?? ""}"',
      '"vehicalDescription"': '"${vehicalDescription ?? ""}"',
      '"isCheckOut"': isCheckOut ?? false,
      '"dateOfCheckIn"': '"${dateOfCheckIn ?? DateTime(2022)}"',
    };
  }

  factory CheckInModel.fromJson(Map<String, dynamic> json) {
    return CheckInModel(
      id: json['id'],
      staffId: json['staffId'],
      customerId: json['customerId'],
      vehicalId: json['vehicalId'],
      staffName: json['staffName'],
      dateOfCheckIn: DateTime.parse(json['dateOfCheckIn']),
      customerName: json['customerName'],
      vehicalLicensePlate: json['vehicalLicensePlate'],
      isCheckOut: json['isCheckOut'],
      vehicalDescription: json['vehicalDescription'],
    );
  }
}
