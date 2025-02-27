import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/core/presentation/widgets/custom_outlined_button.dart';
import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/features/home/presentation/bottom_nav_bar_items.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/bloc/make_report_bloc.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/models/step_model.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/page/get_to_work_error_page.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/page/make_report_page.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/list_steps_and_sections/section_item_widget.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/list_steps_and_sections/step_item_widget.dart';
import 'package:leasing_company/features/make_report/presentation/reject_delefate_report_page/page/delegate_report_page.dart';
import 'package:leasing_company/features/make_report/presentation/reject_delefate_report_page/page/reject_report_info_page.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_model.dart';
import 'package:leasing_company/generated/l10n.dart';

class ReportPreviewPage extends StatefulWidget {
  final CompanyEntity company;
  final Article article;
  final ReviewTemplateModel template;
  final Review? review;
  final bool isOpenedFromReviews;
  final int? index;

  ReportPreviewPage({
    required this.company,
    required this.article,
    required this.template,
    this.review,
    this.isOpenedFromReviews = false,
    this.index,
  });

  @override
  State<StatefulWidget> createState() => ReportPreviewPageState();
}

class ReportPreviewPageState extends State<ReportPreviewPage> with WidgetsBindingObserver {
  MakeReportBloc? bloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = MakeReportBloc(
          company: widget.company,
          review: widget.review,
          articleLocalId: widget.article.id,
          articleRemoteId: widget.article.remoteId,
          originalTemplate: widget.template, context: context,
        );
        bloc.add(MakeReportPreviewEvent(context));
        return bloc;
      },
      child: BlocConsumer<MakeReportBloc, MakeReportState>(
        listener: (context, state) async {
          if (state is MakeReportDatabaseRefreshState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ReportPreviewPage(
                  company: state.companyEntity,
                  article: state.reviews[widget.index!].article,
                  template: ReviewTemplateModel.fromDBModel(state.reviews[widget.index!]),
                  review: state.reviews[widget.index!].review,
                  isOpenedFromReviews: true,
                  index: widget.index,
                ),
              ),
            );
          }

          if (state is MakeReportLeaveState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (route) => true,
              arguments: widget.isOpenedFromReviews ? Modules.reviews.getIndex() : null,
            );
          }
          if (state is GotToWorkState) {
            if (state.available) {
              var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MakeReportPage(
                        company: widget.company,
                        article: widget.article,
                        template: widget.template,
                        review: widget.review,
                        isOpenedFromReviews: true,
                        index: widget.index),
                  ));
              if (result == 'pop') Navigator.pop(context);
            } else {
              var result = await Navigator.push(context, MaterialPageRoute(builder: (_) => GetToWorkErrorPage()));
              if (result == 'pop') Navigator.pop(context);
            }
          }
        },
        builder: (BuildContext context, MakeReportState state) {
          bloc ??= context.read<MakeReportBloc>();
          if (state is MakeReportDatabaseRefreshState || state is GotToWorkState) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is MakeReportPreviewState) {
            final listStepsAndSections = _matchingStepsToSections(state);
            if (state.steps.isNotEmpty) {
              final keys = state.steps.map((e) => GlobalKey()).toList();
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                final stepItemContext = keys[state.currentStepIndex >= 2 ? state.currentStepIndex - 2 : 0].currentContext;
                if (stepItemContext != null) {
                  Scrollable.ensureVisible(
                    stepItemContext,
                    duration: Duration(milliseconds: 500),
                  );
                }
              });

              return Scaffold(
                  appBar: AppBar(
                    elevation: 1.5,
                    title: Text(widget.template.name),
                  ),
                  body: ListView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(top: 16, bottom: 30),
                    children: [
                      ...listStepsAndSections.map((item) {
                        if (item.runtimeType == StepModel) {
                          final step = item as StepModel;
                          return StepItemWidget(
                            step: step,
                            stepIndex: state.steps.indexOf(step),
                            isTemplateExpandable: false,
                            isReportPreviewPage: true,
                          );
                        }
                        if (item.runtimeType == ReviewSection) {
                          final section = item as ReviewSection;
                          final sectionSteps = section.isSelfCreated
                              ? state.steps.where((step) => step.localSectionId == section.id).toList()
                              : state.steps.where((step) => step.sectionId == section.remoteId).toList();
                          return SectionItemWidget(
                            section: section,
                            sectionSteps: sectionSteps,
                            allSteps: state.steps,
                            template: state.template,
                            isReportPreviewPage: true,
                          );
                        }
                        return Text('A critical error has occurred');
                      }).toList(),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: CustomOutlinedButton(
                            text: S.of(context).taskInfoScreenTakeToWorkButtonTitle,
                            backgroundColor: Color(0xFF246BFD),
                            onPressed: () async {
                              bloc?.add(GetToWorkOnPressesEvent(reviewOrTaskTitle: widget.template.name, objectTitle: widget.article.title));
                            }),
                      ),
                      state.template.delegationAvailable
                          ? Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
                              child: CustomOutlinedButton(
                                  text: S.of(context).toDelegate,
                                  backgroundColor: Colors.transparent,
                                  borderColor: Color(0xFF246BFD),
                                  textStyle: TextStyle(color: Color(0xFF246BFD), fontSize: 16, fontWeight: FontWeight.w700),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DelegateReportPage(
                                                reviewTemplateId: state.template.remoteId,
                                                companyUuid: widget.company.uuid,
                                                reviewOrTaskTitle: widget.template.name,
                                                objectTitle: widget.article.title)));
                                  }),
                            )
                          : SizedBox(height: 20),
                      state.template.rejectionAvailable
                          ? Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: CustomOutlinedButton(
                                  text: S.of(context).taskInfoRefuseButtonTitle,
                                  backgroundColor: Colors.transparent,
                                  borderColor: Color(0xFF246BFD),
                                  textStyle: TextStyle(color: Color(0xFF246BFD), fontSize: 16, fontWeight: FontWeight.w700),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => RejectReportIngoPage(
                                                reviewTemplateId: state.template.remoteId,
                                                companyUuid: widget.company.uuid,
                                                reviewOrTaskTitle: widget.template.name,
                                                objectTitle: widget.article.title)));
                                  }),
                            )
                          : SizedBox(height: 20),
                      SizedBox(height: 30),
                    ],
                  ));
            } else {
              if (widget.isOpenedFromReviews) {
                // bloc?.add(OnDatabaseInsertError(uuid: state.review.uuid));
                return Scaffold(body: Center(child: CircularProgressIndicator()));
              }
            }
          }
          return Scaffold(
            body: Center(
              child: Text(S.of(context).makeReportPageUndefinedState + state.toString()),
            ),
          );
        },
      ),
    );
  }

  List<dynamic> _matchingStepsToSections(MakeReportPreviewState state) {
    final List<dynamic> listStepsAndSections = [];
    int? sectionId = -1;
    for (final step in state.steps) {
      if (step.sectionId == null && step.localSectionId == null) {
        listStepsAndSections.add(step);
      }
      if (step.sectionId != null && step.sectionId != sectionId) {
        final sections = state.sections!.where((section) => section.remoteId == step.sectionId);
        if (sections.isNotEmpty) {
          listStepsAndSections.add(sections.first);
          sectionId = step.sectionId;
        } else
          listStepsAndSections.add(step);
      }
    }
    return listStepsAndSections;
  }
}
