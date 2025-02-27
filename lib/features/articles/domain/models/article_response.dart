
import 'package:leasing_company/core/drift/drift.dart';

abstract class ArticleStoreResponse {}

class SuccessArticleStoreResponse extends ArticleStoreResponse {}

class ValidationFailedArticleStoreResponse extends ArticleStoreResponse {
  late Map errors;
}

abstract class ArticlesResponse {}

class SuccessArticlesResponse extends ArticlesResponse {
  List<Article> articles;

  SuccessArticlesResponse(this.articles);
}

class FailedArticlesResponse extends ArticlesResponse {}
