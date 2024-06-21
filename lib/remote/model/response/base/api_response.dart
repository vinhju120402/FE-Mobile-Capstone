class ApiResponse<T> {
  List<T> data;
  bool success;
  String message;

  ApiResponse(
      {required this.data, required this.success, required this.message});

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) create) {
    var dataList = json['data'] as List;
    List<T> dataItems = dataList.map((item) => create(item)).toList();

    return ApiResponse(
      data: dataItems,
      success: json['success'],
      message: json['message'],
    );
  }
}
