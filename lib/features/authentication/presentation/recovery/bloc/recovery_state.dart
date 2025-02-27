abstract class RecoveryState {}

class RecoveryReadyState extends RecoveryState {}

class RecoverySendSmsState extends RecoveryState {}

class RecoveryValidationFailureState extends RecoveryState {
  final Map errors;

  RecoveryValidationFailureState(this.errors);
}

class RecoverySuccessState extends RecoveryState {}

class RecoveryFailureState extends RecoveryState {}
