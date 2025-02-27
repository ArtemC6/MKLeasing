import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leasing_company/features/make_report/domain/models/reject_delegate_response_models.dart';
import 'package:leasing_company/features/make_report/domain/repositories/reject_delegate_repository.dart';
import 'package:leasing_company/main.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'reject_delegate_report_event.dart';
part 'reject_delegate_report_state.dart';

class RejectDelegateReportBloc
    extends Bloc<RejectDelegateReportEvent, RejectDelegateReportState> {
  final _rejectDelegateRepository = getIt<RejectDelegateRepository>();

  RejectDelegateReportBloc() : super(RejectDelegateReadyState()) {
    on<RejectPressedEvent>(_mapRejectPressedToState);
    on<CheckPhoneForDelegatePressedEvent>(
        _mapCheckPhoneForDelegatePressedToState);
    on<DelegatePressedEvent>(_mapDelegatePressedToState);
  }

  Future<void> _mapRejectPressedToState(
      RejectPressedEvent event, Emitter<RejectDelegateReportState> emit) async {
    try {
      emit(RejectInProgressState());
      RejectResponse rejectResponse = await _rejectDelegateRepository.reject(
          companyUuid: event.companyUuid,
          reviewTemplateId: event.reviewTemplateId,
          reason: event.reason,
          newUserPhone: event.newUserPhone,
          newUserName: event.newUserName,
          newUserCompanyName: event.newUserCompanyName,
          newUserPosition: event.newUserPosition);
      if (rejectResponse is SuccessRejectResponse) {
        emit(RejectSuccessState());
      }
      if (rejectResponse is ValidationFailedRejectResponse) {
        emit(RejectDelegateValidationFailureState(rejectResponse.errors));
      }
    } catch (exception, stackTrace) {
      print(exception);
      print(stackTrace);
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(RejectDelegateErrorState());
    }
  }

  Future<void> _mapCheckPhoneForDelegatePressedToState(
      CheckPhoneForDelegatePressedEvent event,
      Emitter<RejectDelegateReportState> emit) async {
    try {
      emit(CheckPhoneForDelegationProgressState());
      DelegateResponse delegateResponse =
          await _rejectDelegateRepository.checkPhoneForDelegate(
              companyUuid: event.companyUuid,
              reviewTemplateId: event.reviewTemplateId,
              phone: event.phone);
      if (delegateResponse is SuccessCheckPhoneForDelegateResponse) {
        emit(CheckPhoneForDelegationSuccessState(
            exists: delegateResponse.exists,
            allowedCreate: delegateResponse.allowedCreate));
      }
      if (delegateResponse is ValidationFailedDelegateResponse) {
        emit(RejectDelegateValidationFailureState(delegateResponse.errors));
      }
    } catch (exception, stackTrace) {
      print(exception);
      print(stackTrace);
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(RejectDelegateErrorState());
    }
  }

  Future<void> _mapDelegatePressedToState(DelegatePressedEvent event,
      Emitter<RejectDelegateReportState> emit) async {
    try {
      emit(DelegateInProgressState());
      DelegateResponse delegateResponse =
          await _rejectDelegateRepository.delegate(
              companyUuid: event.companyUuid,
              reviewTemplateId: event.reviewTemplateId,
              reason: event.reason,
              phone: event.phone,
              email: event.email,
              firstname: event.firstname,
              lastname: event.lastname,
              companyName: event.companyName,
              position: event.position);
      if (delegateResponse is SuccessDelegateResponse) {
        emit(DelegateSuccessState());
      }
      if (delegateResponse is ValidationFailedDelegateResponse) {
        emit(RejectDelegateValidationFailureState(delegateResponse.errors));
      }
    } catch (exception, stackTrace) {
      print(exception);
      print(stackTrace);
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(RejectDelegateErrorState());
    }
  }
}
