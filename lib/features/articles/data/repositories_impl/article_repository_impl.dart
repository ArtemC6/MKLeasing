import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:drift/drift.dart';
import 'package:leasing_company/api/ArticleService.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/articles/data/data_sources/article_remote_data_source.dart';
import 'package:leasing_company/features/articles/domain/models/article_mini_model.dart';
import 'package:leasing_company/features/articles/domain/models/article_response.dart';
import 'package:leasing_company/features/articles/domain/repositories/article_repository.dart';
import 'package:leasing_company/main.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleService _articleService;
  final ArticleRemoteDataSource _remoteDataSource;

  ArticleRepositoryImpl(this._articleService, this._remoteDataSource);

  @override
  Future<List<Article>> getListForCompany(String companyUuid) async {
    return (database.select(database.articles)..where((tbl) => tbl.companyUuid.equals(companyUuid))).get();
  }

  @override
  Future<int> getCountForCompany(String companyUuid) async {
    var countQuery = countAll(filter: database.articles.companyUuid.equals(companyUuid));

    TypedResult result = await (database.selectOnly(database.articles)..addColumns([countQuery])).getSingle();

    return result.rawData.data['c0'] as int;
  }

  @override
  Future<ArticleStoreResponse> store({required String companyUuid, required ArticleType articleType, required Map properties}) async {
    final http.Response response = await _articleService.store(
      companyUuid: companyUuid,
      articleTypeId: articleType.remoteId,
      properties: properties,
    );

    if (response.statusCode == 201) {
      return SuccessArticleStoreResponse();
    }

    if (response.statusCode == 422) {
      final dynamic json = jsonDecode(response.body);

      final ValidationFailedArticleStoreResponse validationFailedResponse = ValidationFailedArticleStoreResponse();
      validationFailedResponse.errors = json['errors'];

      return validationFailedResponse;
    }

    throw Exception();
  }

  @override
  Future<Article?> getByRemoteId(String companyUuid, int remoteArticleId) {
    return (database.select(database.articles)..where((tbl) => tbl.companyUuid.equals(companyUuid) & tbl.remoteId.equals(remoteArticleId))).getSingleOrNull();
  }

  @override
  Future<List<ArticleMiniModel>> getArticlesByType({required String companyUuid, required int articleTypeId}) {
    return _remoteDataSource.getArticlesByType(companyUuid: companyUuid, articleTypeId: articleTypeId);
  }

  @override
  Future<List<PropertiesArticle>> getProperties() {
    return (database.select(database.propertiesArticles)..where((tbl) => tbl.articleId.isNotNull())).get();
  }

  @override
  Future<List<ArticleType>> getArticleType({required String companyUuid, required int articleTypeId}) {
    return (database.select(database.articleTypes)..where((tbl) => tbl.remoteId.equals(articleTypeId))).get();
  }

  @override
  Future<List<InfoModal>> getModals() async {
    final data = await (database.select(database.infoModals)).get();

    return data;
  }

  @override
  Future<void> notificationIsOpened({required int remoteId}) async {
    await (database.update(database.reviewTemplates)
          ..where(
            (tbl) => tbl.remoteId.equals(remoteId),
          ))
        .write(
      ReviewTemplatesCompanion(
        isOpened: Value(true),
      ),
    );
  }
}
