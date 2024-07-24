import 'package:eduappui/remote/model/response/school_year_response.dart';
import 'package:eduappui/remote/service/api/school_year_api.dart';

abstract class SchoolYearRepository {
  Future<List<SchoolYearResponse>> getListSchoolYear(int schoolId);
}

class SchoolYearRepositoryImpl extends SchoolYearRepository {
  final SchoolYearApi schoolYearApi = SchoolYearApi();

  @override
  Future<List<SchoolYearResponse>> getListSchoolYear(int schoolId) async {
    List<dynamic> dynamicList = await schoolYearApi.getListSchoolYearBySchoolId(schoolId);
    List<SchoolYearResponse> responseList = dynamicList.map((item) => SchoolYearResponse.fromJson(item)).toList();
    return responseList;
  }
}
