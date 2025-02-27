import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:leasing_company/features/company/domain/use_cases/get_current_company.dart';
import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/features/home/services/reviews_count_service.dart';
import 'package:leasing_company/features/main/domain/models/notification_model.dart';
import 'package:leasing_company/features/main/domain/use_cases/change_company_use_case.dart';
import 'package:leasing_company/features/main/domain/use_cases/get_companies_use_case.dart';
import 'package:leasing_company/features/main/domain/use_cases/get_notifications_use_case.dart';
import 'package:leasing_company/main.dart';
import 'package:meta/meta.dart';

part 'main_page_event.dart';

part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final GetNotificationsUseCase _getNotificationsUseCase = getIt();
  final GetCurrentCompany _getCurrentCompanyUseCase = getIt();
  final GetCompaniesUseCase _getCompaniesUseCase = getIt();
  final ChangeCompanyUseCase _changeCompanyUseCase = getIt();
  final ReviewsCountService _reviewsCountService= getIt();

  MainPageBloc() : super(MainPageState()) {
    on<InitialEvent>(_onInitialEvent);
    on<ChangeDisplayNotificationModeEvent>(
        _onChangeDisplayNotificationModeEvent);
    on<ChangedCompanyEvent>(_onChangeCompanyEvent);
    on<RefreshNotificationsListEvent>(_onRefreshNotificationsListEvent);
  }

  Future<void> _onInitialEvent(_, Emitter emit) async {
    List<NotificationModel>? notifications;
    bool isHaveExceptions = false;
    try {
      notifications = await _getNotificationsUseCase();
    } catch (e) {
      isHaveExceptions = true;
    }
    final companies = await _getCompaniesUseCase();
    final currentCompany = await _getCurrentCompanyUseCase();
    emit(state.copyWith(
      notifications: notifications,
      companiesList: companies,
      selectedCompany: currentCompany,
      isHaveExceptions: isHaveExceptions,
    ));
  }

  void _onChangeDisplayNotificationModeEvent(_, Emitter emit) {
    emit(state.copyWith(isShowAllNotifications: !state.isShowAllNotifications));
  }

  Future<void> _onChangeCompanyEvent(
      ChangedCompanyEvent event, Emitter emit) async {
    await _changeCompanyUseCase(event.company);
    await _reviewsCountService.updateData();
    add(InitialEvent());
  }

  Future<void> _onRefreshNotificationsListEvent(
      RefreshNotificationsListEvent event, Emitter emit) async {
    List<NotificationModel>? notifications;
    bool isHaveExceptions = false;
    try {
      notifications = await _getNotificationsUseCase();
    } catch (e) {
      isHaveExceptions = true;
    }
    event.completer.complete();
    emit(state.copyWith(
      notifications: notifications,
      isHaveExceptions: isHaveExceptions,
    ));
  }
}
