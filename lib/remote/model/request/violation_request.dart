import 'dart:io';

class ViolationRequest {
  int classId;
  int studentInClassId;
  int violationTypeId;
  int? teacherId;
  String code;
  String violationName;
  String? description;
  DateTime? date;
  List<File>? images;

  ViolationRequest({
    required this.classId,
    required this.studentInClassId,
    required this.violationTypeId,
    this.teacherId,
    required this.code,
    required this.violationName,
    this.description,
    this.date,
    this.images,
  });

  factory ViolationRequest.fromJson(Map<String, dynamic> json) {
    return ViolationRequest(
      classId: json['ClassId'],
      studentInClassId: json['StudentInClassId'],
      violationTypeId: json['ViolationTypeId'],
      teacherId: json['TeacherId'],
      code: json['Code'],
      violationName: json['ViolationName'],
      description: json['Description'],
      date: json['Date'] != null ? DateTime.parse(json['Date']) : null,
      images: json['Images'] != null ? List<File>.from(json['Images'].map((x) => File(x))) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ClassId': classId,
      'StudentInClassId': studentInClassId,
      'ViolationTypeId': violationTypeId,
      'TeacherId': teacherId,
      'Code': code,
      'ViolationName': violationName,
      'Description': description,
      'Date': date?.toIso8601String(),
      'Images': images?.map((file) => file.path).toList(),
    };
  }

  @override
  String toString() {
    return 'ViolationRequest(classId: $classId, studentInClassId: $studentInClassId, violationTypeId: $violationTypeId, teacherId: $teacherId, code: $code, violationName: $violationName, description: $description, date: $date, images: $images)';
  }
}
