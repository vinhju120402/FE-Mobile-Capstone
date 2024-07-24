class SchoolYearResponse {
  int? schoolYearId;
  int? year;
  String? startDate;
  String? endDate;
  int? schoolId;
  String? schoolName;
  String? status;

  SchoolYearResponse(
      {this.schoolYearId, this.year, this.startDate, this.endDate, this.schoolId, this.schoolName, this.status});

  SchoolYearResponse.fromJson(Map<String, dynamic> json) {
    schoolYearId = json['schoolYearId'];
    year = json['year'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    schoolId = json['schoolId'];
    schoolName = json['schoolName'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['schoolYearId'] = schoolYearId;
    data['year'] = year;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['schoolId'] = schoolId;
    data['schoolName'] = schoolName;
    data['status'] = status;
    return data;
  }
}
