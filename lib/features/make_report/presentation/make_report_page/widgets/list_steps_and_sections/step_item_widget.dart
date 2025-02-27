import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/bloc/make_report_bloc.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/models/step_model.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/models/step_status.dart';
import 'package:leasing_company/features/make_report/presentation/review_copy_section_steps/page/review_copy_step_page.dart';
import 'package:leasing_company/features/make_report/presentation/review_create_step/page/review_steps_create_page.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_dto.dart';
import 'package:leasing_company/generated/l10n.dart';

class StepItemWidget extends StatelessWidget {
  final StepModel step;
  final int stepIndex;
  final bool isTemplateExpandable;
  final bool isOpenedInSection;
  final bool isLastStepInSection;
  final bool isReportPreviewPage;

  const StepItemWidget({
    Key? key,
    required this.step,
    required this.stepIndex,
    required this.isTemplateExpandable,
    this.isOpenedInSection = false,
    this.isLastStepInSection = false,
    this.isReportPreviewPage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('copu ' + step.repeatable.toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isOpenedInSection
            ? Center(
                child: Dash(
                  direction: Axis.vertical,
                  length: 5,
                  dashLength: 1.5,
                  dashThickness: 2.5,
                  dashColor: Color(0xFF246BFD),
                ),
              )
            : SizedBox(height: 5),
        GestureDetector(
          onTap: !isReportPreviewPage
              ? () {
                  context.read<MakeReportBloc>().add(
                        MakeReportChangeStepEvent(stepIndex: stepIndex),
                      );
                }
              : () {},
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: step.stepStatus.getBackgroundColor(),
                  border: Border.all(
                    color: step.stepStatus.getMainColor(),
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(26, 18, 16, 18),
                margin: EdgeInsets.only(left: 34, right: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.title,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: step.stepStatus == StepStatus.valid
                        ? Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: step.stepStatus.getMainColor(),
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 24,
                            ),
                          )
                        : Container(
                            width: 30,
                            height: 30,
                            //padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: step.stepStatus.getMainColor(),
                            ),
                            child: Center(
                              child: Text(
                                '${stepIndex + 1}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              if ((isTemplateExpandable || step.expandable || step.repeatable) && !isReportPreviewPage)
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      final bloc = context.read<MakeReportBloc>();
                      showModalBottomSheet(
                        context: context,
                        isDismissible: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(28),
                          ),
                        ),
                        builder: (context) => _buildStepBottomSheetWidget(
                          bloc,
                          context,
                          stepIndex,
                          step,
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 16),
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xFF246BFD),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 0.2,
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 2,
                            )
                          ]),
                      child: Icon(
                        Icons.add,
                        color: Color(0xFF246BFD),
                        size: 18,
                      ),
                    ),
                  ),
                )),
              if (step.required)
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: EdgeInsets.only(right: 41, top: 10),
                      padding: EdgeInsets.all(2),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Color(0xFFF64E60),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        isOpenedInSection
            ? isLastStepInSection
                ? SizedBox(height: 5)
                : Center(
                    child: Dash(
                      direction: Axis.vertical,
                      length: 5,
                      dashLength: 1.5,
                      dashThickness: 2.5,
                      dashColor: Color(0xFF246BFD),
                    ),
                  )
            : SizedBox(height: 5),
      ],
    );
  }

  Widget _buildStepBottomSheetWidget(
    MakeReportBloc bloc,
    BuildContext context,
    int stepIndex,
    StepModel step,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 25),
        Container(
          width: 40,
          height: 3,
          decoration: BoxDecoration(
            color: Color(0xFFE0E0E0),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        SizedBox(height: 16),
        Text(
          S.of(context).selectAnAction,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 20),
        Divider(
          color: Color(0xFFEEEEEE),
          thickness: 1.5,
        ),
        SizedBox(height: 12),
        if (step.expandable || isTemplateExpandable)
          _buildTextButton(
            text: S.of(context).createNewStep,
            icon: Icons.add,
            onTap: () async {
              final newStep = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ReviewStepsCreatePage(
                  sectionId: step.sectionId,
                  localSectionId: step.localSectionId,
                ),
              ));
              if (newStep != null && newStep is ReviewTemplateStepDTO) {
                bloc.add(CreateNewStepsEvent([newStep], stepIndex));
              }
              Navigator.of(context).pop();
            },
          ),
        SizedBox(height: 4),
        if (step.repeatable)
          _buildTextButton(
            text: S.of(context).copyStep,
            icon: Icons.copy,
            onTap: () async {
              final listCopiedSteps = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ReviewCopyStepPage(step: step),
                ),
              );
              if (listCopiedSteps != null) {
                bloc.add(
                  CreateNewStepsEvent(listCopiedSteps, stepIndex),
                );
              }
              Navigator.of(context).pop();
            },
          ),
        SizedBox(height: 28),
      ],
    );
  }

  Widget _buildTextButton({
    required String text,
    required IconData icon,
    required Function() onTap,
  }) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            SizedBox(width: 34),
            Icon(icon, color: Color(0xFF246BFD), size: 20),
            SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                color: Color(0xFF246BFD),
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
