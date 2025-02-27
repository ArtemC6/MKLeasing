import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:leasing_company/api/api.dart';

class ArticleService extends Api {
  Future<http.Response> store(
      {required String companyUuid,
      required int articleTypeId,
      required Map properties}) async {
    String accessToken = this.appBox.get('accessToken');

    var response = await  Api.client.post(Uri.parse(this.url + "/v1/articles"),
        body: jsonEncode(
            {'article_type_id': articleTypeId, 'properties': properties}),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + accessToken,
          'Tenant-Id': companyUuid,
        }).timeout(Duration(seconds: 15));

    return response;
  }
}
