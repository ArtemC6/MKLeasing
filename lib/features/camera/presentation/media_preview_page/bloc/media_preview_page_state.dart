part of 'media_preview_page_bloc.dart';

class MediaPreviewPageState {
  final bool isPlayingVideoMode;
  final int mediaFileIndex;
  final bool isLandscapeOrientation;
  final bool isPageLoading;
  final List<bool> contentOrientationsIsPortraitList;

  MediaPreviewPageState({
    required this.mediaFileIndex,
    this.isPlayingVideoMode = false,
    this.isLandscapeOrientation = false,
    this.isPageLoading = true,
    this.contentOrientationsIsPortraitList = const [],
  });

  MediaPreviewPageState copyWith({
    bool? isPlayingVideoMode,
    int? mediaFileIndex,
    bool? isLandscapeOrientation,
    bool? isPageLoading,
    List<bool>? contentOrientationsIsPortraitList,
  }) {
    return MediaPreviewPageState(
      mediaFileIndex: mediaFileIndex ?? this.mediaFileIndex,
      isPlayingVideoMode: isPlayingVideoMode ?? this.isPlayingVideoMode,
      isLandscapeOrientation:
          isLandscapeOrientation ?? this.isLandscapeOrientation,
      isPageLoading: isPageLoading ?? this.isPageLoading,
      contentOrientationsIsPortraitList: contentOrientationsIsPortraitList ??
          this.contentOrientationsIsPortraitList,
    );
  }
}
