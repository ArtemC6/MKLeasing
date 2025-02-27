import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginReadyState extends LoginState {}

class LoginInProgressState extends LoginState {}

class LoginSuccessState extends LoginState {}

class RegistrationSuccessState extends LoginState {
  final bool multiCompanyMode;

  RegistrationSuccessState(this.multiCompanyMode);
}

class LoginValidationFailureState extends LoginState {
  final Map errors;

  LoginValidationFailureState(this.errors);
}

class LoginErrorState extends LoginState {}
