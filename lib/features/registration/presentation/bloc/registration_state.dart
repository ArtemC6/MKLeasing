part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpReadyState extends RegistrationState {}

class SignUpInProgressState extends RegistrationState {}

class SignUpBeginSuccessState extends RegistrationState {}

class SignUpFinishSuccessState extends RegistrationState {
  SignUpFinishSuccessState({required this.awaitingValidation});

  final bool awaitingValidation;
}
class SignUpValidationFailureState extends RegistrationState {
  final Map errors;

  SignUpValidationFailureState(this.errors);
}
class SignUpDisabledState extends RegistrationState {
  final String error;

  SignUpDisabledState(this.error);
}

class SignUpErrorState extends RegistrationState {}
