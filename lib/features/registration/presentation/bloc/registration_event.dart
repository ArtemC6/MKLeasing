part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpBeginButtonPressedEvent extends RegistrationEvent {
  final int? tenantId;

  SignUpBeginButtonPressedEvent({required this.tenantId});
}

class SignUpFinishButtonPressedEvent extends RegistrationEvent {
  final int tenantId;
  final String firstname;
  final String lastname;
  final String company;
  final String phone;
  final String email;

  SignUpFinishButtonPressedEvent(
      {required this.tenantId,
      required this.firstname,
      required this.lastname,
      required this.company,
      required this.phone,
      required this.email});
}
