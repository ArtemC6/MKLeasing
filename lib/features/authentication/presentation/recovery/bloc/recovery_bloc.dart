import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/features/authentication/domain/models/user_repository_response_models.dart';
import 'package:leasing_company/features/authentication/domain/repositories/user_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'recovery_event.dart';
import 'recovery_state.dart';

class RecoveryBloc extends Bloc<RecoveryEvent, RecoveryState> {
  final UserRepository userRepository;

  RecoveryBloc({required this.userRepository}) : super(RecoveryReadyState()) {
    on<RecoveryButtonPressedEvent>(_mapButtonPressedToState);
  }

  Future<void> _mapButtonPressedToState(
      RecoveryButtonPressedEvent event, Emitter<RecoveryState> emit) async {
    try {
      emit(RecoverySendSmsState());

      final recoverySmsResponse = await userRepository.recoverySms(event.phone);

      if (recoverySmsResponse is ValidationFailedRecoverySmsResponse) {
        emit(RecoveryValidationFailureState(recoverySmsResponse.errors));
      }

      if (recoverySmsResponse is SuccessRecoverySmsResponse) {
        emit(RecoverySuccessState());
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(RecoveryFailureState());
    }
  }
}
