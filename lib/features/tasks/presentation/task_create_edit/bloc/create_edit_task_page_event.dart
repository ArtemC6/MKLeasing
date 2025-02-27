part of 'create_edit_task_page_bloc.dart';

@immutable
abstract class CreateEditTaskPageEvent {}

class InitEvent extends CreateEditTaskPageEvent {}

class NeedSendForApprovalValueChangedEvent extends CreateEditTaskPageEvent {}

class ArticleChangedEvent extends CreateEditTaskPageEvent {
  final ArticleMiniEntity selectedArticle;

  ArticleChangedEvent(this.selectedArticle);
}

class ReviewTemplateChangedEvent extends CreateEditTaskPageEvent {
  final ReviewTemplateMiniEntity selectedReviewTemplate;

  ReviewTemplateChangedEvent(this.selectedReviewTemplate);
}

class PriorityChangedEvent extends CreateEditTaskPageEvent {
  final TaskPriority selectedPriority;

  PriorityChangedEvent(this.selectedPriority);
}

class UpdateUiEvent extends CreateEditTaskPageEvent {}

class GetArticlesByTypeEvent extends CreateEditTaskPageEvent {
  final int articleTypeId;

  GetArticlesByTypeEvent(this.articleTypeId);
}

class SaveButtonPressedEvent extends CreateEditTaskPageEvent {
  final String reviewOrTaskTitle;
  final String objectTitle;

  SaveButtonPressedEvent(
      {required this.reviewOrTaskTitle, required this.objectTitle});
}

class ShowValidateResults extends CreateEditTaskPageEvent {}