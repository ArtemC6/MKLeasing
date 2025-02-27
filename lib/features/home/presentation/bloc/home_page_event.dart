part of 'home_page_bloc.dart';

@immutable
abstract class HomePageEvent {}

class LoadEvent extends HomePageEvent {}

class PageChangedEvent extends HomePageEvent {
  final int newPageIndex;

  PageChangedEvent(this.newPageIndex);
}

class AddButtonPressedEvent extends HomePageEvent {}

class CompanyChangedEvent extends HomePageEvent {
  final CompanyEntity newCompany;

  CompanyChangedEvent(this.newCompany);
}
