import 'dart:async';

abstract class ChooseCreatingArticleTypeEvent {}

class ChooseCreatingArticleTypeLoadEvent
    extends ChooseCreatingArticleTypeEvent {}

class ChooseCreatingArticleTypeRefreshEvent
    extends ChooseCreatingArticleTypeEvent {
  final Completer refreshCompleter;

  ChooseCreatingArticleTypeRefreshEvent(this.refreshCompleter);
}

class ChooseCreatingArticleTypeHandleButtonEvent
    extends ChooseCreatingArticleTypeEvent {
  final int articleTypeId;

  ChooseCreatingArticleTypeHandleButtonEvent(this.articleTypeId);
}
