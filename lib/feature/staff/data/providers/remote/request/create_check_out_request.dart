class CreateCheckOutRequest {
  int? checkInId;
  String? dateOfCheckOut;

  CreateCheckOutRequest(this.checkInId, this.dateOfCheckOut);

  Map<String, dynamic> toJson() {
    return {
      'checkInId': checkInId,
      'dateOfCheckOut': dateOfCheckOut,
    };
  }
}
