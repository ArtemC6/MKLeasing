import 'package:leasing_company/core/drift/drift.dart';

abstract class ChooseCreatingArticleTypeState {}

class ChooseCreatingArticleTypeLoadInProgressState
    extends ChooseCreatingArticleTypeState {}

class ChooseCreatingArticleTypeLoadSuccessState
    extends ChooseCreatingArticleTypeState {
  final List<ArticleType> articleTypes;

  ChooseCreatingArticleTypeLoadSuccessState(this.articleTypes);
}

class ChooseCreatingArticleTypeChoosenState
    extends ChooseCreatingArticleTypeState {
  final int articleTypeId;

  ChooseCreatingArticleTypeChoosenState(this.articleTypeId);
}

class ChooseCreatingArticleTypeLoadFailureState
    extends ChooseCreatingArticleTypeState {}
