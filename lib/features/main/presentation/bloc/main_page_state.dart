part of 'main_page_bloc.dart';

class MainPageState {
  final List<NotificationModel>? notifications;
  final bool isShowAllNotifications;
  final List<CompanyEntity>? companiesList;
  final CompanyEntity? selectedCompany;
  final bool isHaveExceptions;

  MainPageState({
    this.notifications,
    this.isShowAllNotifications = false,
    this.companiesList,
    this.selectedCompany,
    this.isHaveExceptions = false,
  });

  MainPageState copyWith({
    List<NotificationModel>? notifications,
    bool? isShowAllNotifications,
    List<CompanyEntity>? companiesList,
    CompanyEntity? selectedCompany,
    bool? isHaveExceptions,
  }) {
    return MainPageState(
      notifications: notifications ?? this.notifications,
      isShowAllNotifications:
          isShowAllNotifications ?? this.isShowAllNotifications,
      companiesList: companiesList ?? this.companiesList,
      selectedCompany: selectedCompany ?? this.selectedCompany,
      isHaveExceptions: isHaveExceptions ?? this.isHaveExceptions
    );
  }
}
