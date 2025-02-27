import 'package:leasing_company/core/drift/drift.dart';

abstract class ArticleAddEvent {}

class ArticleAddLoadEvent extends ArticleAddEvent {
  ArticleAddLoadEvent();
}

class ArticleAddStoreEvent extends ArticleAddEvent {
  final ArticleType articleType;
  final List<ArticleTypeProperty> articleTypeProperties;
  final Map properties;

  ArticleAddStoreEvent({
    required this.articleType,
    required this.articleTypeProperties,
    required this.properties,
  });
}
