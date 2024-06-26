// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  // App API Endpoints
  static String api_base_url = '${dotenv.env['API_BASE_URL']}';

  static String login = '$api_base_url/auths/login';

  static String history_violation = '$api_base_url/violations';

  static String violation_group = '$api_base_url/violation-groups';

  static String violation_type = '$api_base_url/violation-types/search';

  static String class_list = '$api_base_url/classes';

  static String student_in_class = '$api_base_url/student-in-classes/search';

  static String create_student_violation = '$api_base_url/violations/student';

  static String edit_violation_history = '$api_base_url/violations';

  static String get_duty_schedule = '$api_base_url/patrol-schedules';
}
