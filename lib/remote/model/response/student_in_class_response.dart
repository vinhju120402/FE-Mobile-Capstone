class StudentInClassResponse {
  int? studentInClassId;
  int? classId;
  int? studentId;
  String? studentName;
  String? enrollDate;
  String? isSupervisor;
  String? status;

  StudentInClassResponse(
      {this.studentInClassId, this.classId, this.studentId, this.enrollDate, this.isSupervisor, this.status});

  StudentInClassResponse.fromJson(Map<String, dynamic> json) {
    studentInClassId = json['studentInClassId'];
    classId = json['classId'];
    studentId = json['studentId'];
    studentName = json['studentName'];
    enrollDate = json['enrollDate'];
    isSupervisor = json['isSupervisor'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['studentInClassId'] = studentInClassId;
    data['classId'] = classId;
    data['studentId'] = studentId;
    data['studentName'] = studentName;
    data['enrollDate'] = enrollDate;
    data['isSupervisor'] = isSupervisor;
    data['status'] = status;
    return data;
  }

  //Defined to string
  @override
  String toString() {
    return 'StudentInClassResponse{studentInClassId: $studentInClassId, classId: $classId, studentId: $studentId, studentName: $studentName , enrollDate: $enrollDate, isSupervisor: $isSupervisor, status: $status}';
  }
}
