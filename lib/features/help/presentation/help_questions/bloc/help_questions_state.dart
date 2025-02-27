import 'package:leasing_company/core/drift/drift.dart';

abstract class HelpQuestionsState {}

class HelpQuestionsLoadInProgressState extends HelpQuestionsState {}

class HelpQuestionsSuccessState extends HelpQuestionsState {
  final List<HelpQuestion> helpQuestions;

  HelpQuestionsSuccessState(this.helpQuestions);
}

class HelpQuestionsFailureState extends HelpQuestionsState {}
