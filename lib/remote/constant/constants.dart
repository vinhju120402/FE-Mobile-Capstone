// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  // App API Endpoints
  static String api_base_url = '${dotenv.env['API_BASE_URL']}';
}
