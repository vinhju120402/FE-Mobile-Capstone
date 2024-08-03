class UserResquest {
  int? schoolId;
  String? code;
  String? name;
  String? phone;
  String? password;
  String? address;

  UserResquest({this.schoolId, this.code, this.name, this.phone, this.password, this.address});

  UserResquest.fromJson(Map<String, dynamic> json) {
    schoolId = json['schoolId'];
    code = json['code'];
    name = json['name'];
    phone = json['phone'];
    password = json['password'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['schoolId'] = schoolId;
    data['code'] = code;
    data['name'] = name;
    data['phone'] = phone;
    data['password'] = password;
    data['address'] = address;
    return data;
  }
}
