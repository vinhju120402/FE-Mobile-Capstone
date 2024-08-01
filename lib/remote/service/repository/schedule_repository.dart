import 'package:eduappui/remote/model/response/schedule_response.dart';
import 'package:eduappui/remote/service/api/schedule_api.dart';

abstract class ScheduleRepository {
  Future<List<ScheduleResponse>> getDutyScheduleBySupervisorId(int id);
}

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleApi scheduleApi = ScheduleApi();

  @override
  Future<List<ScheduleResponse>> getDutyScheduleBySupervisorId(int id) async {
    List<dynamic> dynamicList = await scheduleApi.getDutyScheduleBySupervisorId(id);
    List<ScheduleResponse> responseList = dynamicList.map((item) => ScheduleResponse.fromJson(item)).toList();
    return responseList;
  }
}
