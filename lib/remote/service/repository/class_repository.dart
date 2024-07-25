import 'package:eduappui/remote/model/response/class_reponse.dart';
import 'package:eduappui/remote/service/api/class_api.dart';

abstract class ClassRepository {
  Future<List<ClassResponse>> getListClass(int schoolId);
}

class ClassRepositoryImpl extends ClassRepository {
  final ClassApi classApi = ClassApi();

  @override
  Future<List<ClassResponse>> getListClass(int schoolId) async {
    List<dynamic> dynamicList = await classApi.getListClass(schoolId);
    List<ClassResponse> responseList = dynamicList.map((item) => ClassResponse.fromJson(item)).toList();
    return responseList;
  }
}
