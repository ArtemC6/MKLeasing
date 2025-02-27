part of 'review_list_bloc.dart';

@immutable
abstract class ReviewListState {}

class ReviewsInitialState extends ReviewListState {}

class ReviewsNeedToChooseCompanyState extends ReviewListState {}

class ReviewsLoadSuccessState extends ReviewListState {
  final List<ReviewModel> reviews;
  final int filterIndex;
  final String searchText;
  final bool isSearchShowing;
  final CompanyEntity companyEntity;

  ReviewsLoadSuccessState({
    required this.reviews,
    required this.filterIndex,
    required this.searchText,
    required this.isSearchShowing,
    required this.companyEntity,
  });
}

class ReviewsLoadFailureState extends ReviewListState {}

