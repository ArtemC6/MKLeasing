import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/core/presentation/widgets/custom_outlined_button.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/bloc/make_report_bloc.dart';
import 'package:leasing_company/features/make_report/presentation/review_create_step/page/review_steps_create_page.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_dto.dart';
import 'package:leasing_company/generated/l10n.dart';

class ButtonsWidget extends StatefulWidget {
  const ButtonsWidget({Key? key}) : super(key: key);

  @override
  State<ButtonsWidget> createState() => _ButtonsWidgetState();
}

class _ButtonsWidgetState extends State<ButtonsWidget> {
  bool isButtonsVisible = true;

  @override
  Widget build(BuildContext context) {
    final state = context.read<MakeReportBloc>().state as MakeReportReadyState;
    final isNeedShowNextButton =
        state.currentStepIndex < state.steps.length - 1 ||
            state.isAddStepCheckBoxSelected;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xFFFDFDFD),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(26),
          topRight: Radius.circular(26),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              setState(() {
                isButtonsVisible = !isButtonsVisible;
              });
            },
            child: Ink(
              child: Center(
                child: Icon(
                  isButtonsVisible
                      ? Icons.keyboard_arrow_down_outlined
                      : Icons.keyboard_arrow_up_outlined,
                  color: Colors.black87,
                  size: 30,
                ),
              ),
            ),
          ),
          SizedBox(height: isButtonsVisible ? 8 : 4),
          if (isButtonsVisible && isNeedShowNextButton)
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: CustomOutlinedButton(
                text: S.of(context).toNextStepButtonTitle,
                onPressed: () async {
                  if (state.isAddStepCheckBoxSelected) {
                    final newStep =
                        await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ReviewStepsCreatePage(
                        sectionId:
                            state.steps[state.currentStepIndex].sectionId,
                        localSectionId:
                            state.steps[state.currentStepIndex].localSectionId,
                      ),
                    ));
                    if (newStep != null && newStep is ReviewTemplateStepDTO) {
                      context.read<MakeReportBloc>().add(CreateNewStepsEvent(
                            [newStep],
                            state.currentStepIndex,
                          ));
                    }
                  }
                  context.read<MakeReportBloc>()
                      .add(MakeReportNextStepEvent(context: context));
                },
                backgroundColor: Color(0xFF246BFD),
              ),
            ),
          if (isButtonsVisible)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: CustomOutlinedButton(
                overlayColor: Colors.grey.withOpacity(0.1),
                text: S.of(context).makeReportPageFinish,
                onPressed: () {
                  context
                      .read<MakeReportBloc>()
                      .add(EndButtonPressedEvent(context));
                },
                backgroundColor: Colors.transparent,
                foregroundColor: Color(0xFF0055FF),
                borderColor: Color(0xFF0055FF),
              ),
            ),
        ],
      ),
    );
  }
}
