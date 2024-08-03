// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  // App API Endpoints
  static String api_base_url = '${dotenv.env['API_BASE_URL']}';

  static String login = '$api_base_url/auths/login';

  static String history_violation = '$api_base_url/violations';

  static String violation_group = '$api_base_url/violation-groups';

  static String violation_type = '$api_base_url/violation-types';

  static String class_list = '$api_base_url/classes';

  static String student_in_class = '$api_base_url/student-in-classes/search';

  static String create_student_violation = '$api_base_url/violations/student';

  static String create_teacher_violation = '$api_base_url/violations/supervisor';

  static String edit_violation = '$api_base_url/violations';

  static String edit_teacher_violation = '$api_base_url/violations/supervisor';

  static String get_duty_schedule = '$api_base_url/patrol-schedules';

  static String get_violation_config = '$api_base_url/violation-configs';

  static String get_user = '$api_base_url/users';

  static String get_school_year = '$api_base_url/school-years';

  // Constant String
  static const String access_token = 'access_token';
  static const String expired_at = 'expired_at';
  static const String user_id = 'user_id';
  static const String school_id = 'school_id';
}
