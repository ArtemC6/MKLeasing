import 'package:leasing_company/features/articles/domain/models/article_mini_model.dart';

abstract class ArticleRemoteDataSource {
  Future<List<ArticleMiniModel>> getArticlesByType({
    required String companyUuid,
    required int articleTypeId,
  });
}

