import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/articles/domain/repositories/article_type_repository.dart';

class GetArticleTypeByIdUseCase {
  final ArticleTypeRepository _repository;

  GetArticleTypeByIdUseCase(this._repository);

  Future<ArticleType?> call(int articleTypeId) =>
      _repository.getById(articleTypeId);
}
