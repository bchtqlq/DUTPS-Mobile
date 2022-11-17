class CreateCheckInRequest {
  String? customerUsername;
  int? vehicalId;
  String? dateOfCheckIn;

  CreateCheckInRequest(this.customerUsername, this.vehicalId, this.dateOfCheckIn);

  Map<String, dynamic> toJson() {
    return {
      'customerUsername': customerUsername,
      'vehicalId': vehicalId,
      'dateOfCheckIn': dateOfCheckIn,
    };
  }
}
