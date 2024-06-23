// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  // App API Endpoints
  static String api_base_url = '${dotenv.env['API_BASE_URL']}';

  static String history_violation = '$api_base_url/violations';

  static String violation_group = '$api_base_url/violation-groups';

  static String violation_type = '$api_base_url/violation-types/search';

  static String class_list = '$api_base_url/classes';
}
