import 'dart:io';

class ViolationRequest {
  int? schoolId;
  int? schoolYear;
  int classId;
  int studentInClassId;
  int? scheduleId;
  int violationTypeId;
  int? teacherId;
  String violationName;
  String? description;
  DateTime? date;
  List<File>? images;

  ViolationRequest({
    this.schoolId,
    this.schoolYear,
    required this.classId,
    required this.studentInClassId,
    this.scheduleId,
    required this.violationTypeId,
    this.teacherId,
    required this.violationName,
    this.description,
    this.date,
    this.images,
  });

  factory ViolationRequest.fromJson(Map<String, dynamic> json) {
    return ViolationRequest(
      schoolId: json['SchoolId'],
      schoolYear: json['Year'],
      classId: json['ClassId'],
      studentInClassId: json['StudentInClassId'],
      scheduleId: json['ScheduleId'],
      violationTypeId: json['ViolationTypeId'],
      teacherId: json['TeacherId'],
      violationName: json['ViolationName'],
      description: json['Description'],
      date: json['Date'] != null ? DateTime.parse(json['Date']) : null,
      images: json['Images'] != null ? List<File>.from(json['Images'].map((x) => File(x))) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'SchoolId': schoolId,
      'Year': schoolYear,
      'ClassId': classId,
      'StudentInClassId': studentInClassId,
      'ScheduleId': scheduleId,
      'ViolationTypeId': violationTypeId,
      'TeacherId': teacherId,
      'ViolationName': violationName,
      'Description': description,
      'Date': date?.toIso8601String(),
      'Images': images?.map((file) => file.path).toList(),
    };
  }

  @override
  String toString() {
    return 'ViolationRequest(SchoolId: $schoolId, SchoolYear: $schoolYear ,classId: $classId, studentInClassId: $studentInClassId, scheduleId : $scheduleId, violationTypeId: $violationTypeId, teacherId: $teacherId, violationName: $violationName, description: $description, date: $date, images: $images)';
  }
}
