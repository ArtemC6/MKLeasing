part of 'media_preview_page_bloc.dart';

@immutable
abstract class MediaPreviewPageEvent {}

class InitialEvent extends MediaPreviewPageEvent {}

class HideAppBarAndCommentEvent extends MediaPreviewPageEvent {}

class ShowAppBarAndCommentEvent extends MediaPreviewPageEvent {}

class UpdateUiEvent extends MediaPreviewPageEvent {}

class ChangedContentEvent extends MediaPreviewPageEvent {
  final int newIndex;

  ChangedContentEvent(this.newIndex);
}

class ChangedOrientationEvent extends MediaPreviewPageEvent {
  final bool isLandscapeOrientation;

  ChangedOrientationEvent(this.isLandscapeOrientation);
}
