class ViolationConfigResponse {
  int? violationConfigId;
  int? violationTypeId;
  String? violationTypeName;
  int? minusPoints;
  String? description;
  String? status;

  ViolationConfigResponse(
      {this.violationConfigId,
      this.violationTypeId,
      this.violationTypeName,
      this.minusPoints,
      this.description,
      this.status});

  ViolationConfigResponse.fromJson(Map<String, dynamic> json) {
    violationConfigId = json['violationConfigId'];
    violationTypeId = json['violationTypeId'];
    violationTypeName = json['violationTypeName'];
    minusPoints = json['minusPoints'];
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['violationConfigId'] = violationConfigId;
    data['violationTypeId'] = violationTypeId;
    data['violationTypeName'] = violationTypeName;
    data['minusPoints'] = minusPoints;
    data['description'] = description;
    data['status'] = status;
    return data;
  }
}
