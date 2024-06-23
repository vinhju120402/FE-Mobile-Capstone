class ClassResponse {
  int? classId;
  int? schoolYearId;
  int? classGroupId;
  String? code;
  String? room;
  String? name;
  int? totalPoint;

  ClassResponse({this.classId, this.schoolYearId, this.classGroupId, this.code, this.room, this.name, this.totalPoint});

  ClassResponse.fromJson(Map<String, dynamic> json) {
    classId = json['classId'];
    schoolYearId = json['schoolYearId'];
    classGroupId = json['classGroupId'];
    code = json['code'];
    room = json['room'];
    name = json['name'];
    totalPoint = json['totalPoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['classId'] = classId;
    data['schoolYearId'] = schoolYearId;
    data['classGroupId'] = classGroupId;
    data['code'] = code;
    data['room'] = room;
    data['name'] = name;
    data['totalPoint'] = totalPoint;
    return data;
  }
}
