import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:leasing_company/core/drift/drift.dart';

abstract class ArticlesListEvent extends Equatable {
  const ArticlesListEvent();

  @override
  List<Object> get props => [];
}

class ArticlesLoadEvent extends ArticlesListEvent {}

class ArticlesRefreshEvent extends ArticlesListEvent {
  final Completer refreshCompleter;

  ArticlesRefreshEvent(this.refreshCompleter);
}

class ArticleAddedEvent extends ArticlesListEvent {
  final Article article;

  const ArticleAddedEvent(this.article);

  @override
  List<Object> get props => [article];

  @override
  String toString() => 'ArticleAdded { article: $article }';
}

class ArticleSendOfflineReviewsEvent extends ArticlesListEvent {
  final List<Article> articles;

  ArticleSendOfflineReviewsEvent(this.articles);
}

class SearchArticlesEvent extends ArticlesListEvent {
  final String searchText;

  SearchArticlesEvent(this.searchText);
}

class SearchShowingModeChangedEvent extends ArticlesListEvent {}
