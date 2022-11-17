import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.camel, ignoreNullMembers: true, name: "list")
class HistoryModel {
  DateTime? dateOfCheckIn;
  DateTime? dateOfCheckOut;
  int? vehicalId;
  String? vehicalLicensePlate;
  String? vehicalDescription;
  int? customerId;
  String? customerName;
  String? staffCheckInName;
  String? staffCheckOutName;

  HistoryModel({
    this.dateOfCheckIn,
    this.dateOfCheckOut,
    this.vehicalId,
    this.vehicalLicensePlate,
    this.vehicalDescription,
    this.customerId,
    this.customerName,
    this.staffCheckInName,
    this.staffCheckOutName,
  });

  Map<String, dynamic> toJson() {
    return {
      '"dateOfCheckIn"': '"${dateOfCheckIn ?? DateTime(2022)}"',
      '"dateOfCheckOut"': '"${dateOfCheckOut ?? DateTime(2022)}"',
      '"vehicalId"': vehicalId,
      '"vehicalLicensePlate"': '"${vehicalLicensePlate ?? ""}"',
      '"vehicalDescription"': '"${vehicalDescription ?? ""}"',
      '"customerId"': customerId,
      '"customerName"': '"${customerName ?? ""}"',
      '"staffCheckInName"': '"${staffCheckInName ?? ""}"',
      '"staffCheckOutName"': '"${staffCheckOutName ?? ""}"',
    };
  }

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      dateOfCheckIn: DateTime.parse(json['dateOfCheckIn']),
      dateOfCheckOut: DateTime.parse(json['dateOfCheckOut']),
      vehicalId: json['vehicalId'],
      vehicalLicensePlate: json['vehicalLicensePlate'],
      vehicalDescription: json['vehicalDescription'],
      customerId: json['customerId'],
      customerName: json['customerName'],
      staffCheckInName: json['staffCheckInName'],
      staffCheckOutName: json['staffCheckOutName'],
    );
  }
}
