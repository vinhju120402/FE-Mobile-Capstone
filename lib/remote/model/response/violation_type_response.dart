class ViolationTypeResponse {
  int? violationTypeId;
  String? vioTypeName;
  int? violationGroupId;
  String? vioGroupName;
  String? description;

  ViolationTypeResponse(
      {this.violationTypeId, this.vioTypeName, this.violationGroupId, this.vioGroupName, this.description});

  ViolationTypeResponse.fromJson(Map<String, dynamic> json) {
    violationTypeId = json['violationTypeId'];
    vioTypeName = json['vioTypeName'];
    violationGroupId = json['violationGroupId'];
    vioGroupName = json['vioGroupName'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['violationTypeId'] = violationTypeId;
    data['vioTypeName'] = vioTypeName;
    data['violationGroupId'] = violationGroupId;
    data['vioGroupName'] = vioGroupName;
    data['description'] = description;
    return data;
  }
}
