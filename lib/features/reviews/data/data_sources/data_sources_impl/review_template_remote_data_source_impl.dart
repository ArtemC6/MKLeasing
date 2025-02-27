import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:leasing_company/api/api.dart';
import 'package:leasing_company/api/remote_data_source.dart';
import 'package:leasing_company/features/reviews/data/data_sources/review_template_remote_data_source.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_mini_model.dart';
import 'package:leasing_company/main.dart';

class ReviewTemplateRemoteDataSourceImpl extends RemoteDataSource
    implements ReviewTemplateRemoteDataSource {
  @override
  Future<List<ReviewTemplateMiniModel>> getAll(
      {required String companyUuid, required String type}) async {
    Box appBox = getIt.get(instanceName: 'AppBox');
    String accessToken = appBox.get('accessToken');

    String url = this.apiUrl + '/v1/review-templates/all?type=$type';

    var response = await Api.client.get(
    
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + accessToken,
        'Tenant-Id': companyUuid,
      },
    ).timeout(Duration(seconds: 15));

    var data = jsonDecode(response.body);

    List<ReviewTemplateMiniModel> templates =
        List<ReviewTemplateMiniModel>.from(data.map(
            (templateJson) => ReviewTemplateMiniModel.fromJson(templateJson)));

    return templates;
  }

  @override
  Future<bool> checkAvailability(
      int reviewTemplateId, String companyUuid) async {
    try {
      String accessToken = Api().appBox.get('accessToken');

      var response = await Api.client
          .post(Uri.parse(Api().url + "/v3/reviews/check-availability"),
              body: jsonEncode({
                "review_template_id": reviewTemplateId,
              }),
              headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + accessToken,
            'Tenant-Id': companyUuid,
            'Content-Type': 'application/json',
          }).timeout(Duration(seconds: 15),
              onTimeout: () => http.Response('Timeout', 408));
      var data = jsonDecode(response.body);

      return response.statusCode == 200 ? data['available'] : true;
    } catch (e) {
      return true;
    }
  }
}
