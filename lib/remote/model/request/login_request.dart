class LoginRequest {
  String? phoneNumber;
  String? password;

  LoginRequest({this.phoneNumber, this.password});

  Map<String, dynamic> toJson() {
    return {
      'username': phoneNumber,
      'password': password,
    };
  }
}
