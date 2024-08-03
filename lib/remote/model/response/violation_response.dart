class ViolationResponse {
  int? violationId;
  int? userId;
  String? createdBy;
  int? classId;
  String? className;
  int? year;
  int? studentInClassId;
  String? studentName;
  String? studentCode;
  int? violationTypeId;
  String? violationTypeName;
  int? violationGroupId;
  String? violationGroupName;
  String? violationName;
  String? description;
  String? date;
  List<String>? imageUrls;
  String? createdAt;
  String? updatedAt;
  String? status;

  ViolationResponse(
      {this.violationId,
      this.userId,
      this.createdBy,
      this.classId,
      this.className,
      this.year,
      this.studentInClassId,
      this.studentName,
      this.studentCode,
      this.violationTypeId,
      this.violationTypeName,
      this.violationGroupId,
      this.violationGroupName,
      this.violationName,
      this.description,
      this.date,
      this.imageUrls,
      this.createdAt,
      this.updatedAt,
      this.status});

  ViolationResponse.fromJson(Map<String, dynamic> json) {
    violationId = json['violationId'];
    userId = json['userId'];
    createdBy = json['createdBy'];
    classId = json['classId'];
    className = json['className'];
    year = json['year'];
    studentInClassId = json['studentInClassId'];
    studentName = json['studentName'];
    studentCode = json['studentCode'];
    violationTypeId = json['violationTypeId'];
    violationTypeName = json['violationTypeName'];
    violationGroupId = json['violationGroupId'];
    violationGroupName = json['violationGroupName'];
    violationName = json['violationName'];
    description = json['description'];
    date = json['date'];
    imageUrls = json['imageUrls'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['violationId'] = violationId;
    data['userId'] = userId;
    data['createdBy'] = createdBy;
    data['classId'] = classId;
    data['className'] = className;
    data['year'] = year;
    data['studentInClassId'] = studentInClassId;
    data['studentName'] = studentName;
    data['studentCode'] = studentCode;
    data['violationTypeId'] = violationTypeId;
    data['violationTypeName'] = violationTypeName;
    data['violationGroupId'] = violationGroupId;
    data['violationGroupName'] = violationGroupName;
    data['violationName'] = violationName;
    data['description'] = description;
    data['date'] = date;
    data['imageUrls'] = imageUrls;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['status'] = status;
    return data;
  }
}
