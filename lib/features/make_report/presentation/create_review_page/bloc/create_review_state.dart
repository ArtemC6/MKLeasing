part of 'create_review_bloc.dart';

class CreateReviewState {
  final Article? selectedArticle;
  final ReviewTemplate? selectedReviewTemplate;
  final List<ReviewTemplate>? listReviewTemplates;
  final List<Article>? listArticles;
  final bool isNeedHideValidateResults;
  final CompanyEntity? currentCompany;
  final String errorMessage;

  CreateReviewState({
    this.selectedArticle,
    this.selectedReviewTemplate,
    this.listReviewTemplates,
    this.listArticles,
    this.isNeedHideValidateResults = true,
    this.currentCompany,
    this.errorMessage = '',
  });

  CreateReviewState copyWith({
    Article? selectedArticle,
    dynamic selectedReviewTemplate,
    dynamic listReviewTemplates,
    List<Article>? listArticles,
    CompanyEntity? currentCompany,
    bool? isNeedHideValidateResults,
    String? errorMessage,
  }) {
    return CreateReviewState(
      isNeedHideValidateResults:
          isNeedHideValidateResults ?? this.isNeedHideValidateResults,
      selectedArticle: selectedArticle != null
          ? selectedArticle.remoteId == -1
              ? null
              : selectedArticle
          : this.selectedArticle,
      selectedReviewTemplate: selectedReviewTemplate is String
          ? null
          : selectedReviewTemplate is ReviewTemplate
              ? selectedReviewTemplate
              : this.selectedReviewTemplate,
      listReviewTemplates: listReviewTemplates is String
          ? null
          : listReviewTemplates is List
              ? listReviewTemplates as List<ReviewTemplate>
              : this.listReviewTemplates,
      listArticles: listArticles ?? this.listArticles,
      currentCompany: currentCompany ?? this.currentCompany,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
