import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressedEvent extends LoginEvent {
  final String phone;
  final String password;
  final BuildContext context;

  LoginButtonPressedEvent({
    required this.phone,
    required this.password,
    required this.context,
  });
}

class RegistrationButtonPressedEvent extends LoginEvent {
  RegistrationButtonPressedEvent();
}
