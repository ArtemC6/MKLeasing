import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/company/domain/repositories/company_repository.dart';
import 'package:leasing_company/features/help/domain/repositories/help_question_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'help_questions_event.dart';
import 'help_questions_state.dart';

class HelpQuestionsBloc extends Bloc<HelpQuestionsEvent, HelpQuestionsState> {
  final HelpQuestionRepository helpQuestionRepository;
  final CompanyRepository companyRepository;

  HelpQuestionsBloc(
      {required this.helpQuestionRepository, required this.companyRepository})
      : super(HelpQuestionsLoadInProgressState()) {
    on<HelpQuestionsLoadInProgressEvent>(_mapQuestionsLoadInProgressToState);

    add(HelpQuestionsLoadInProgressEvent());
  }

  Future<void> _mapQuestionsLoadInProgressToState(
      HelpQuestionsEvent event, Emitter<HelpQuestionsState> emit) async {
    try {
      emit(HelpQuestionsLoadInProgressState());

      var company = await companyRepository.getCurrent();

      List<HelpQuestion> helpQuestions =
          await this.helpQuestionRepository.getList(company!);

      emit(HelpQuestionsSuccessState(helpQuestions));
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(HelpQuestionsFailureState());
    }
  }
}
