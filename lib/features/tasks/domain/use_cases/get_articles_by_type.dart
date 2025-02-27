import 'package:leasing_company/features/articles/domain/entities/article_mini_entity.dart';
import 'package:leasing_company/features/articles/domain/repositories/article_repository.dart';

class GetArticlesByTypeUseCase {
  final ArticleRepository _repository;

  GetArticlesByTypeUseCase(this._repository);

  Future<List<ArticleMiniEntity>> call(String companyUuid, int articleTypeId) {
    return _repository.getArticlesByType(
      companyUuid: companyUuid,
      articleTypeId: articleTypeId,
    );
  }
}
