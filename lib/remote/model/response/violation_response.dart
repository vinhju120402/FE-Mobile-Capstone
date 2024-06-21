class ViolationResponse {
  int? violationId;
  int? classId;
  int? violationTypeId;
  int? teacherId;
  String? code;
  String? violationName;
  String? description;
  String? date;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;

  ViolationResponse(
      {this.violationId,
      this.classId,
      this.violationTypeId,
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
    violationTypeId = json['violationTypeId'];
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
    data['violationTypeId'] = violationTypeId;
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

  //defined to string
  @override
  String toString() {
    return 'HistoryViolation{violationId: $violationId, classId: $classId, violationTypeId: $violationTypeId, teacherId: $teacherId, code: $code, violationName: $violationName, description: $description, date: $date, createdAt: $createdAt, createdBy: $createdBy, updatedAt: $updatedAt, updatedBy: $updatedBy}';
  }
}
