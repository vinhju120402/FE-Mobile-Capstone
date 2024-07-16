class ViolationResponse {
  int? violationId;
  int? classId;
  int? studentInClassId;
  String? studentName;
  int? violationTypeId;
  String? violationTypeName;
  int? violationGroupId;
  String? violationGroupName;
  int? teacherId;
  String? code;
  String? violationName;
  String? description;
  String? date;
  String? createdAt;
  int? createdBy;
  String? updatedAt;
  String? updatedBy;

  ViolationResponse(
      {this.violationId,
      this.classId,
      this.studentInClassId,
      this.studentName,
      this.violationTypeId,
      this.violationTypeName,
      this.violationGroupId,
      this.violationGroupName,
      this.teacherId,
      this.code,
      this.violationName,
      this.description,
      this.date,
      this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy});

  ViolationResponse.fromJson(Map<String, dynamic> json) {
    violationId = json['violationId'];
    classId = json['classId'];
    studentInClassId = json['studentInClassId'];
    studentName = json['studentName'];
    violationTypeId = json['violationTypeId'];
    violationTypeName = json['violationTypeName'];
    violationGroupId = json['violationGroupId'];
    violationGroupName = json['violationGroupName'];
    teacherId = json['teacherId'];
    code = json['code'];
    violationName = json['violationName'];
    description = json['description'];
    date = json['date'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['violationId'] = violationId;
    data['classId'] = classId;
    data['studentInClassId'] = studentInClassId;
    data['studentName'] = studentName;
    data['violationTypeId'] = violationTypeId;
    data['violationTypeName'] = violationTypeName;
    data['violationGroupId'] = violationGroupId;
    data['violationGroupName'] = violationGroupName;
    data['teacherId'] = teacherId;
    data['code'] = code;
    data['violationName'] = violationName;
    data['description'] = description;
    data['date'] = date;
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['updatedAt'] = updatedAt;
    data['updatedBy'] = updatedBy;
    return data;
  }
}
