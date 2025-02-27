import 'package:leasing_company/features/articles/domain/entities/article_mini_entity.dart';
import 'package:leasing_company/features/articles/domain/repositories/article_repository.dart';

class GetArticlesCountByCompanyUseCase {
  final ArticleRepository _repository;

  GetArticlesCountByCompanyUseCase(this._repository);

  Future<int> call(String companyUuid) {
    return _repository.getCountForCompany(companyUuid);
  }
}
