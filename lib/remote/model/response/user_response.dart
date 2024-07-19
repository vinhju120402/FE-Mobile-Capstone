class UserResponse {
  int? userId;
  int? schoolId;
  String? schoolName;
  String? code;
  String? userName;
  String? phone;
  String? password;
  String? address;
  int? roleId;
  String? roleName;
  String? status;

  UserResponse(
      {this.userId,
      this.schoolId,
      this.schoolName,
      this.code,
      this.userName,
      this.phone,
      this.password,
      this.address,
      this.roleId,
      this.roleName,
      this.status});

  UserResponse.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    schoolId = json['schoolId'];
    schoolName = json['schoolName'];
    code = json['code'];
    userName = json['userName'];
    phone = json['phone'];
    password = json['password'];
    address = json['address'];
    roleId = json['roleId'];
    roleName = json['roleName'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['schoolId'] = schoolId;
    data['schoolName'] = schoolName;
    data['code'] = code;
    data['userName'] = userName;
    data['phone'] = phone;
    data['password'] = password;
    data['address'] = address;
    data['roleId'] = roleId;
    data['roleName'] = roleName;
    data['status'] = status;
    return data;
  }
}
