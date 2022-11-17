class AddVehicalRequest {
  String? licensePlate;
  String? description;

  AddVehicalRequest(this.licensePlate, this.description);

  Map<String, dynamic> toJson() {
    return {
      'licensePlate': licensePlate,
      'description': description,
    };
  }
}
