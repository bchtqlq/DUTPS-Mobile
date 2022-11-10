class RegisterRequest {
  String? username;
  String? password;
  String? email;
  String? confirmPassword;

  RegisterRequest(this.username, this.password, this.email, this.confirmPassword);

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}
