import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:leasing_company/api/api.dart';

class DadataService extends Api {
  Future<http.Response> findPartyById(String inn) async {
    String accessToken = Api.dadataApiKey;
    var response = await http
        .post(
            Uri.parse(
                "https://suggestions.dadata.ru/suggestions/api/4_1/rs/findById/party"),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Token ' + accessToken,
            },
            body: jsonEncode({'query': inn}))
        .timeout(Duration(seconds: 15));
    return response;
  }
}
