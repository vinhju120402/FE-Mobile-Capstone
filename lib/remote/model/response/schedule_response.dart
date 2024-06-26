class ScheduleResponse {
  int? scheduleId;
  int? classId;
  int? supervisorId;
  String? supervisorName;
  int? teacherId;
  String? teacherName;
  String? from;
  String? to;

  ScheduleResponse(
      {this.scheduleId,
      this.classId,
      this.supervisorId,
      this.supervisorName,
      this.teacherId,
      this.teacherName,
      this.from,
      this.to});

  ScheduleResponse.fromJson(Map<String, dynamic> json) {
    scheduleId = json['scheduleId'];
    classId = json['classId'];
    supervisorId = json['supervisorId'];
    supervisorName = json['supervisorName'];
    teacherId = json['teacherId'];
    teacherName = json['teacherName'];
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['scheduleId'] = scheduleId;
    data['classId'] = classId;
    data['supervisorId'] = supervisorId;
    data['supervisorName'] = supervisorName;
    data['teacherId'] = teacherId;
    data['teacherName'] = teacherName;
    data['from'] = from;
    data['to'] = to;
    return data;
  }

  @override
  String toString() {
    return 'ScheduleResponse{scheduleId: $scheduleId, classId: $classId, supervisorId: $supervisorId, supervisorName: $supervisorName, teacherId: $teacherId, teacherName: $teacherName, from: $from, to: $to}';
  }
}
