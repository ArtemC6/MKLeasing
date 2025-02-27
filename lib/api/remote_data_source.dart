import 'package:leasing_company/api/api.dart';

abstract class RemoteDataSource {
  static String baseUrl = Api.baseUrl;
  String apiUrl = "$baseUrl/api";
}
