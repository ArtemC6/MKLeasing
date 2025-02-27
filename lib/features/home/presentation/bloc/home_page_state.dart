part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  List<Object?> get props => [Uuid().v4()];
}

class HomePageInProgressState extends HomePageState {}

class HomePageReadyState extends HomePageState {
  final int actualPageIndex;
  final bool isAddButtonPressed;
  final CompanyEntity company;

  HomePageReadyState({
    required this.actualPageIndex,
    required this.company,
    this.isAddButtonPressed = false,
  });

  HomePageReadyState copyWith({
    int? actualPageIndex,
    CompanyEntity? company,
    bool? isAddButtonPressed,
  }) {
    return HomePageReadyState(
      actualPageIndex: actualPageIndex ?? this.actualPageIndex,
      company: company ?? this.company,
      isAddButtonPressed: isAddButtonPressed ?? this.isAddButtonPressed,
    );
  }

  @override
  List<Object?> get props =>
      [actualPageIndex, isAddButtonPressed, company.uuid];
}

class HomePageChooseCompanyState extends HomePageState{}
