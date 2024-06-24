import 'package:eduappui/remote/model/response/student_in_class_response.dart';
import 'package:eduappui/remote/service/api/student_in_class_api.dart';

abstract class StudentInClassRepository {
  Future<List<StudentInClassResponse>> getListStudent(
      {int? classId, int? studentId, String? enrollDate, bool? isSupervisor, String? status, String? sort});
}

class StudentInClassRepositoryImpl implements StudentInClassRepository {
  final StudentInClassApi studentInClassApi = StudentInClassApi();

  @override
  Future<List<StudentInClassResponse>> getListStudent(
      {int? classId, int? studentId, String? enrollDate, bool? isSupervisor, String? status, String? sort}) async {
    List<dynamic> dynamicList = await studentInClassApi.getListStudent(query: {
      "classId": classId,
      "studentId": studentId,
      "enrollDate": enrollDate,
      "isSupervisor": isSupervisor,
      "status": status,
      "sortOrder": sort ?? "desc"
    });
    List<StudentInClassResponse> responseList =
        dynamicList.map((item) => StudentInClassResponse.fromJson(item)).toList();
    return responseList;
  }
}
