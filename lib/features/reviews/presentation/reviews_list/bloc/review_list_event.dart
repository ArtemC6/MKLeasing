part of 'review_list_bloc.dart';

@immutable
abstract class ReviewListEvent {}

class InitialEvent extends ReviewListEvent {
  final Completer? completer;

  InitialEvent({this.completer});
}

class FilterChangedEvent extends ReviewListEvent {
  final ReviewStatus? reviewStatus;

  FilterChangedEvent(this.reviewStatus);
}

class SearchTextChangedEvent extends ReviewListEvent {
  final String searchText;

  SearchTextChangedEvent(this.searchText);
}

class SearchShowingModeChangedEvent extends ReviewListEvent {}
