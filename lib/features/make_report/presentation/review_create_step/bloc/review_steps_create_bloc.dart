import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/features/make_report/presentation/review_create_step/bloc/review_steps_create_event.dart';
import 'package:leasing_company/features/make_report/presentation/review_create_step/bloc/review_steps_create_state.dart';
import 'package:sentry_flutter/sentry_flutter.dart';


class ReviewStepsCreateBloc
    extends Bloc<ReviewStepsCreateEvent, ReviewStepsCreateState> {
  ReviewStepsCreateBloc() : super(ReviewStepsCreateReadyState()) {
    on<ReviewStepsCreateLoadEvent>(_mapLoadToState);
  }

  Stream<ReviewStepsCreateState> _mapLoadToState(ReviewStepsCreateEvent event,
      Emitter<ReviewStepsCreateState> emit) async* {
    try {
      emit(ReviewStepsCreateReadyState());
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }
}
