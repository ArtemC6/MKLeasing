import 'package:leasing_company/core/drift/drift.dart';

abstract class ArticleTypeRepository {
  Future<ArticleType?> getById(int id);

  Future<List<ArticleType>> getList(String companyUuid);

  Future<List<ArticleType>> getVisibleList(String companyUuid);

  Future<List<ArticleTypeProperty>> getPropertiesForArticleType(
      String companyUuid, int articleTypeId);
}
