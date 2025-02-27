part of 'create_review_bloc.dart';

@immutable
abstract class CreateReviewEvent {}

class InitialEvent extends CreateReviewEvent {
  final S localization;

  InitialEvent(this.localization);
}

class ArticleChangedEvent extends CreateReviewEvent {
  final Article selectedArticle;

  ArticleChangedEvent(this.selectedArticle);
}

class ReviewTemplateChangedEvent extends CreateReviewEvent {
  final ReviewTemplate selectedReviewTemplate;

  ReviewTemplateChangedEvent(this.selectedReviewTemplate);
}

class GetReviewTemplateForArticleEvent extends CreateReviewEvent {}

class ShowValidateResultsEvent extends CreateReviewEvent {}

class OnCreatedReviewEvent extends CreateReviewEvent {
  final String templateTitle;
  final String articleTitle;
  OnCreatedReviewEvent({required this.articleTitle, required this.templateTitle});
}
