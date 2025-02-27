import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/bloc/make_report_bloc.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/models/step_model.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/models/step_status.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/list_steps_and_sections/step_item_widget.dart';
import 'package:leasing_company/features/make_report/presentation/review_copy_section_steps/page/review_copy_section_page.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_model.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SectionItemWidget extends StatefulWidget {
  final ReviewSection section; // TODO: создать ReviewSectionEntity/Model
  final List<StepModel> sectionSteps;
  final List<StepModel> allSteps;
  final ReviewTemplateModel template;
  final bool isReportPreviewPage;

  const SectionItemWidget({
    Key? key,
    required this.section,
    required this.sectionSteps,
    required this.allSteps,
    required this.template,
    this.isReportPreviewPage = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SectionItemWidgetState();
}

class _SectionItemWidgetState extends State<SectionItemWidget> {
  bool isSectionStepsVisible = false;

  @override
  Widget build(BuildContext context) {
    final validStepsCount = widget.sectionSteps.where((element) => element.stepStatus == StepStatus.valid).length;
    final sectionProgress = validStepsCount / widget.sectionSteps.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isSectionStepsVisible = !isSectionStepsVisible;
            });
          },
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: isSectionStepsVisible ? Color(0xFF246BFD).withOpacity(0.1) : Colors.white,
                  border: Border.all(
                    color: isSectionStepsVisible ? Colors.transparent : Color(0xFFA7C4FE),
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(26, 18, 16, 18),
                margin: EdgeInsets.fromLTRB(20, 5, 28, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.section.title,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8),
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(children: [
                        TextSpan(
                          text: S.of(context).stepsCompleted + ': ',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        TextSpan(
                          text: validStepsCount.toString(),
                          style: TextStyle(
                            color: sectionProgress == 1 ? Color(0xFF71FF6F) : Color(0xFF246BFD).withOpacity(0.9),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: '/${widget.sectionSteps.length}',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ]),
                    ),
                    SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: LinearPercentIndicator(
                          backgroundColor: Color(0xFFA7C4FE).withOpacity(0.25),
                          percent: sectionProgress,
                          lineHeight: 6,
                          linearGradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              sectionProgress == 1 ? Color(0xFF71FF6F) : Colors.lightBlueAccent,
                              sectionProgress == 1 ? Color(0xFF71FF6F) : Color(0xFF246BFD).withOpacity(0.9)
                            ],
                          ),
                          padding: EdgeInsets.zero,
                          barRadius: Radius.circular(6),
                        ),
                      ),
                    ),
                    SizedBox(height: 2),
                  ],
                ),
              ),
              if (widget.section.repeatable && !widget.isReportPreviewPage)
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
                        builder: (context) => _buildSectionBottomSheetWidget(
                          bloc,
                          context,
                          widget.section,
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
            ],
          ),
        ),
        isSectionStepsVisible
            ? Center(
                child: Dash(
                  direction: Axis.vertical,
                  length: 6,
                  dashLength: 2,
                  dashThickness: 2.5,
                  dashColor: Color(0xFF246BFD),
                ),
              )
            : SizedBox(height: 5),
        if (isSectionStepsVisible)
          ...widget.sectionSteps.map((step) => StepItemWidget(
                step: step,
                stepIndex: widget.allSteps.indexOf(step),
                isTemplateExpandable: widget.template.expandable,
                isOpenedInSection: true,
                isLastStepInSection: widget.sectionSteps.last == step,
                isReportPreviewPage: widget.isReportPreviewPage,
              )),
        if (isSectionStepsVisible) SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSectionBottomSheetWidget(MakeReportBloc bloc, BuildContext context, ReviewSection section) {
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
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            final copiedSection = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ReviewCopySectionPage(section: section),
              ),
            );
            if (copiedSection != null) {
              bloc.add(CopySectionEvent(copiedSection));
            }
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                SizedBox(width: 34),
                Icon(Icons.copy, color: Color(0xFF246BFD), size: 20),
                SizedBox(width: 12),
                Text(
                  S.of(context).copySection,
                  style: TextStyle(
                    color: Color(0xFF246BFD),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 28),
      ],
    );
  }
}
