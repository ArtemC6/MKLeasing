import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/core/presentation/widgets/custom_outlined_button.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/bloc/make_report_bloc.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/models/step_model.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/list_steps_and_sections/section_item_widget.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/list_steps_and_sections/step_item_widget.dart';
import 'package:leasing_company/generated/l10n.dart';

class ListStepsAndSectionsWidget extends StatelessWidget {
  final MakeReportReadyState state;

  const ListStepsAndSectionsWidget({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listStepsAndSections = _matchingStepsToSections();
    listStepsAndSections.removeWhere((element) {
      if (element is StepModel) {
        return element.parentId == null;
      }
      return false;
    });
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: 16, bottom: 30),
      children: [
        ...listStepsAndSections.map((item) {
          if (item.runtimeType == StepModel) {
            final step = item as StepModel;
            return StepItemWidget(
              step: step,
              stepIndex: state.steps.indexOf(step),
              isTemplateExpandable: state.template.expandable,
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
            );
          }
          return Text('A critical error has occurred');
        }).toList(),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CustomOutlinedButton(
              text: S.of(context).makeReportPageFinish,
              backgroundColor: Color(0xFF246BFD),
              onPressed: () {
                context.read<MakeReportBloc>().add(EndButtonPressedEvent(context));
              }),
        ),
      ],
    );
  }

  List<dynamic> _matchingStepsToSections() {
    final List<dynamic> listStepsAndSections = [];
    int? sectionId = -1;
    int? localSectionId = -1;
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
      if (step.localSectionId != null && step.localSectionId != localSectionId) {
        final sections = state.sections!.where((section) => section.id == step.localSectionId);
        if (sections.isNotEmpty) {
          listStepsAndSections.add(sections.first);
          localSectionId = step.localSectionId;
        } //else listStepsAndSections.add(step);
      }
    }
    return listStepsAndSections;
  }
}
