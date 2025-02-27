import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:leasing_company/api/api.dart';
import 'package:leasing_company/api/remote_data_source.dart';
import 'package:leasing_company/features/articles/data/data_sources/article_remote_data_source.dart';
import 'package:leasing_company/features/articles/domain/models/article_mini_model.dart';
import 'package:leasing_company/main.dart';

class ArticleRemoteDataSourceImpl extends RemoteDataSource implements ArticleRemoteDataSource {
  @override
  Future<List<ArticleMiniModel>> getArticlesByType({
    required String companyUuid,
    required int articleTypeId,
    //mb tut
  }) async {
    Box appBox = getIt.get(instanceName: 'AppBox');
    String accessToken = appBox.get('accessToken');

    String url = this.apiUrl + '/v1/articles/all?article_type_id=$articleTypeId';
    var response = await Api.client.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + accessToken,
        'Tenant-Id': companyUuid,
      },
    ).timeout(Duration(seconds: 15));

    var data = jsonDecode(response.body);
    List<ArticleMiniModel> templates = List<ArticleMiniModel>.from(data['data'].map((templateJson) => ArticleMiniModel.fromJson(templateJson)));

    return templates;
  }
}
