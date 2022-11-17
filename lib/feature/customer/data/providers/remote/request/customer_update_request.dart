class CustomerUpdateRequest {
  String? name;
  int? gender;
  String? birthday;
  String? phoneNumber;
  String? activityClass;
  String? facultyId;

  CustomerUpdateRequest(this.name, this.gender, this.birthday, this.phoneNumber, this.activityClass, this.facultyId);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gender': gender,
      'birthday': birthday,
      'phoneNumber': phoneNumber,
      'class': activityClass,
      'facultyId': facultyId,
    };
  }
}
