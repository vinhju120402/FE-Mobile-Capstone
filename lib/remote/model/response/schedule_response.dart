class ScheduleResponse {
  int? scheduleId;
  int? classId;
  String? className;
  int? userId;
  String? userName;
  int? supervisorId;
  String? supervisorName;
  String? name;
  int? slot;
  String? time;
  String? from;
  String? to;
  String? status;

  ScheduleResponse(
      {this.scheduleId,
      this.classId,
      this.className,
      this.userId,
      this.userName,
      this.supervisorId,
      this.supervisorName,
      this.name,
      this.slot,
      this.time,
      this.from,
      this.to,
      this.status});

  ScheduleResponse.fromJson(Map<String, dynamic> json) {
    scheduleId = json['scheduleId'];
    classId = json['classId'];
    className = json['className'];
    userId = json['userId'];
    userName = json['userName'];
    supervisorId = json['supervisorId'];
    supervisorName = json['supervisorName'];
    name = json['name'];
    slot = json['slot'];
    time = json['time'];
    from = json['from'];
    to = json['to'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['scheduleId'] = scheduleId;
    data['classId'] = classId;
    data['className'] = className;
    data['userId'] = userId;
    data['userName'] = userName;
    data['supervisorId'] = supervisorId;
    data['supervisorName'] = supervisorName;
    data['name'] = name;
    data['slot'] = slot;
    data['time'] = time;
    data['from'] = from;
    data['to'] = to;
    data['status'] = status;
    return data;
  }
}
