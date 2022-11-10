class UsernamePasswordRequest {
  String? username;
  String? password;

  UsernamePasswordRequest(this.username, this.password);

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}