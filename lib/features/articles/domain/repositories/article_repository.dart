import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/articles/domain/models/article_mini_model.dart';
import 'package:leasing_company/features/articles/domain/models/article_response.dart';

abstract class ArticleRepository {
  Future<List<Article>> getListForCompany(String companyUuid);

  Future<int> getCountForCompany(String companyUuid);

  Future<ArticleStoreResponse> store({
    required String companyUuid,
    required ArticleType articleType,
    required Map properties,
  });

  Future<Article?> getByRemoteId(String companyUuid, int remoteArticleId);

  Future<List<ArticleMiniModel>> getArticlesByType({required String companyUuid, required int articleTypeId});

  Future<List<ArticleType>> getArticleType({required String companyUuid, required int articleTypeId});

  Future<List<PropertiesArticle>> getProperties();

  Future<List<InfoModal>> getModals();

  Future<void> notificationIsOpened({required int remoteId});
}
