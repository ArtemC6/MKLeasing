import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/features/registration/domain/models/registration_repository_model.dart';
import 'package:leasing_company/features/registration/domain/repositories/sign_up_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'registration_event.dart';

part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final SignUpRepository _signUpRepository;

  RegistrationBloc({required SignUpRepository signUpRepository})
      : _signUpRepository = signUpRepository,
        super(SignUpReadyState()) {
    on<SignUpBeginButtonPressedEvent>(_mapSignUpBeginButtonPressedToState);
    on<SignUpFinishButtonPressedEvent>(_mapSignUpFinishButtonPressedToState);
  }

  Future<void> _mapSignUpBeginButtonPressedToState(
      SignUpBeginButtonPressedEvent event,
      Emitter<RegistrationState> emit) async {
    try {
      emit(SignUpInProgressState());
      SignUpResponse signUpResponse =
          await _signUpRepository.signUpBegin(event.tenantId);
      if (signUpResponse is SuccessSignUpBeginResponse) {
        emit(SignUpBeginSuccessState());
      }
      if (signUpResponse is ValidationFailedSignUpResponse) {
        emit(SignUpValidationFailureState(signUpResponse.errors));
      }
      if (signUpResponse is RegistrationDisabledSignUpResponse) {
        emit(SignUpDisabledState(signUpResponse.error));
      }
    } catch (exception, stackTrace) {
      print(exception);
      print(stackTrace);
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(SignUpErrorState());
    }
  }

  Future<void> _mapSignUpFinishButtonPressedToState(
      SignUpFinishButtonPressedEvent event,
      Emitter<RegistrationState> emit) async {
    try {
      emit(SignUpInProgressState());
      SignUpResponse signUpResponse = await _signUpRepository.signUpFinish(
          tenantId: event.tenantId,
          firstname: event.firstname,
          lastname: event.lastname,
          patronymic: '',
          company: event.company,
          inn: '',
          position: '',
          phone: event.phone,
          email: event.email);
      if (signUpResponse is SuccessSignUpFinishResponse) {
        emit(SignUpFinishSuccessState(
            awaitingValidation: signUpResponse.awaitingValidation));
      }
      if (signUpResponse is ValidationFailedSignUpResponse) {
        emit(SignUpValidationFailureState(signUpResponse.errors));
      }
      if (signUpResponse is RegistrationDisabledSignUpResponse) {
        emit(SignUpDisabledState(signUpResponse.error));
      }
    } catch (exception, stackTrace) {
      print(exception);
      print(stackTrace);
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(SignUpErrorState());
    }
  }
}
