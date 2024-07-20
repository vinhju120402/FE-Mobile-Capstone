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
  String? violationName;
  String? description;
  String? date;
  List<String>? imageUrls;
  String? createdAt;
  int? createdBy;
  String? updatedAt;
  String? updatedBy;
  String? status;

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
      this.violationName,
      this.description,
      this.date,
      this.imageUrls,
      this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy,
      this.status});

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
    violationName = json['violationName'];
    description = json['description'];
    date = json['date'];
    imageUrls = json['imageUrls'].cast<String>();
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
    status = json['status'];
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
    data['violationName'] = violationName;
    data['description'] = description;
    data['date'] = date;
    data['imageUrls'] = imageUrls;
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['updatedAt'] = updatedAt;
    data['updatedBy'] = updatedBy;
    data['status'] = status;
    return data;
  }
}
