import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/core/presentation/widgets/custom_divider.dart';
import 'package:leasing_company/core/presentation/widgets/on_center_widget.dart';
import 'package:leasing_company/features/help/presentation/help_questions/bloc/help_questions_bloc.dart';
import 'package:leasing_company/features/help/presentation/help_questions/bloc/help_questions_state.dart';
import 'package:leasing_company/generated/l10n.dart';


class HelpQuestionsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HelpQuestionsPageState();
}

class _HelpQuestionsPageState extends State<HelpQuestionsPage> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HelpQuestionsBloc, HelpQuestionsState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(S.of(context).helpQuestionsScreenTitle),
        ),
        body: state is HelpQuestionsSuccessState
            ? state.helpQuestions.isNotEmpty
                ? ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
                    itemCount: state.helpQuestions.length,
                    itemBuilder: (context, index) {
                      return _QuestionItem(
                        question: state.helpQuestions[index],
                      );
                    },
                  )
                : Container(
                    child: OnCenterWidget(
                        message: S.of(context)
                            .helpQuestionsScreenHasNotQuestionsAndAnswers),
                  )
            : Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
      );
    });
  }
}

class _QuestionItem extends StatefulWidget {
  final HelpQuestion question;

  const _QuestionItem({Key? key, required this.question}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuestionItemState();
}

class _QuestionItemState extends State<_QuestionItem> {
  bool isAnswerDisplayed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            offset: const Offset(0, 1),
            blurRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            splashColor: Colors.grey.withOpacity(0.9),
            highlightColor: Colors.grey.withOpacity(0.9),
            onTap: () => setState(() {
              isAnswerDisplayed = !isAnswerDisplayed;
            }),
            borderRadius: BorderRadius.circular(16),
            child: Ink(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Text(
                    widget.question.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  )),
                  AnimatedRotation(
                      turns: isAnswerDisplayed ? -0.25 : 0,
                      duration: Duration(milliseconds: 250),
                      child: Icon(Icons.arrow_forward_ios, size: 18)),
                ],
              ),
            ),
          ),
          if (isAnswerDisplayed) CustomDivider(),
          if (isAnswerDisplayed)
            Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Text(
                widget.question.description,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            )
        ],
      ),
    );
  }
}
