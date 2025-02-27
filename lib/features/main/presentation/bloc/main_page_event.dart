part of 'main_page_bloc.dart';

@immutable
abstract class MainPageEvent {}

class InitialEvent extends MainPageEvent {}

class ChangeDisplayNotificationModeEvent extends MainPageEvent {}

class ChangedCompanyEvent extends MainPageEvent {
  final CompanyEntity company;

  ChangedCompanyEvent(this.company);
}

class RefreshNotificationsListEvent extends MainPageEvent {
  final Completer completer;

  RefreshNotificationsListEvent(this.completer);
}
