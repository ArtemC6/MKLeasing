import 'package:drift/drift.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/articles/domain/repositories/article_type_repository.dart';
import 'package:leasing_company/main.dart';

class ArticleTypeRepositoryImpl implements ArticleTypeRepository{
  Future<ArticleType?> getById(int id) async {
    return (database.select(database.articleTypes)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<List<ArticleType>> getList(String companyUuid) async {
    return (database.select(database.articleTypes)
          ..where((tbl) => tbl.companyUuid.equals(companyUuid)))
        .get();
  }

  Future<List<ArticleType>> getVisibleList(String companyUuid) async {
    return (database.select(database.articleTypes)
          ..where((tbl) =>
              tbl.companyUuid.equals(companyUuid) &
              tbl.visibleForCreating.equals(true)))
        .get();
  }

  Future<List<ArticleTypeProperty>> getPropertiesForArticleType(
      String companyUuid, int articleTypeId) {
    return (database.select(database.articleTypeProperties)
          ..where((tbl) =>
              tbl.companyUuid.equals(companyUuid) &
              tbl.typeId.equals(articleTypeId)))
        .get();
  }
}
