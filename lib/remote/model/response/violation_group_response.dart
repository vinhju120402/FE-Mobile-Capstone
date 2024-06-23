class ViolationGroupResponse {
  int? violationGroupId;
  String? code;
  String? vioGroupName;
  String? description;

  ViolationGroupResponse({this.violationGroupId, this.code, this.vioGroupName, this.description});

  ViolationGroupResponse.fromJson(Map<String, dynamic> json) {
    violationGroupId = json['violationGroupId'];
    code = json['code'];
    vioGroupName = json['vioGroupName'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['violationGroupId'] = violationGroupId;
    data['code'] = code;
    data['vioGroupName'] = vioGroupName;
    data['description'] = description;
    return data;
  }

  @override
  String toString() {
    return 'ViolationGroupResponse{violationGroupId: $violationGroupId, code: $code, vioGroupName: $vioGroupName, description: $description}';
  }
}
