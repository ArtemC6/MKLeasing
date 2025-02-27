abstract class RecoveryEvent {}

class RecoveryButtonPressedEvent extends RecoveryEvent {
  final String phone;

  RecoveryButtonPressedEvent(this.phone);
}
