import 'package:equatable/equatable.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/company/domain/entities/company_entity.dart';

abstract class ArticlesListState extends Equatable {
  const ArticlesListState();

  @override
  List<Object> get props => [];
}

class ArticlesLoadInProgressState extends ArticlesListState {}

class ArticlesNeedToChooseCompanyState extends ArticlesListState {}

class ArticlesLoadSuccessState extends ArticlesListState {
  final CompanyEntity? currentCompany;
  final List<Article> articles;
  final List<ReviewTemplate> templates;
  final List<Review> reviews;
  final List<ReviewTemplateArticle> templatesToArticles;
  final List<PropertiesArticle>? properties;
  final String searchText;
  final bool isSearchShowing;

  ArticlesLoadSuccessState({
    required this.currentCompany,
    required this.articles,
    required this.templates,
    required this.templatesToArticles,
    required this.reviews,
    required this.isSearchShowing,
    this.properties,
    this.searchText = '',
  });

  @override
  List<Object> get props => [...articles, isSearchShowing, templates, reviews];
}

class ArticlesLoadFailureState extends ArticlesListState {}

class ArticlesSendOfflineReviewsProgressState extends ArticlesListState {
  final int max;
  final int current;

  ArticlesSendOfflineReviewsProgressState(this.max, this.current);
}

class ArticlesSendOfflineReviewsSuccessState extends ArticlesListState {}

class ArticlesSendOfflineReviewsFailureState extends ArticlesListState {}
