import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:leasing_company/core/presentation/widgets/custom_box_with_title.dart';
import 'package:leasing_company/core/presentation/widgets/custom_divider.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/bloc/make_report_bloc.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/models/step_model.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/models/step_status.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/page/step_details_page.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/content_preview/content_preview.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/content_preview/content_type_info_widget.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/step_editable_title.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/violation_switch.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_type.dart';
import 'package:leasing_company/features/tasks/presentation/task_execution/widgets/media/form.dart';
import 'package:leasing_company/generated/l10n.dart';

class StepWidget extends StatelessWidget {
  final MakeReportBloc bloc;
  final CompanyEntity company;
  final StepModel step;
  final String cacheStorageDir;
  final List<ReviewStepFile> files;
  final MakeReportReadyState state;

  StepWidget({
    required this.step,
    required this.files,
    required this.state,
    required this.bloc,
    required this.company,
    required this.cacheStorageDir,
  });

  @override
  Widget build(BuildContext context) {
    final filesForStep = files.where((element) =>
      element.stepId == step.localId && element.path != null);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 0),
              child: StepEditableTitle(
                title: step.title,
                // TODO: временно выключено. Задача Битрикс-8473
                isTitleEditable: false, //step.isSelfCreated,
                onChanged: (newTitle) {
                  bloc.add(UpdateStepEvent(step.copyWith(title: newTitle)));
                },
              ),
            ),
            if (step.contentText != null || step.contentImage != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: InkWell(
                  splashColor: Colors.white12,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => StepDetailsPage(step, cacheStorageDir),
                        transitionsBuilder: (_, animation, __, child) {
                          final tween = Tween(begin: Offset(1.0, 0.0), end: Offset.zero).chain(CurveTween(curve: Curves.ease));
                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Ink(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFF246BFD),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          S.of(context).stepInfo,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            if (step.required)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Ink(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFF89B5FC).withOpacity(0.1),
                    border: Border.all(color: Color(0xFF2871E6).withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Шаг обязательный. Для завершения шага необходимо загрузить мультимедиа каждого доступного в этом шаге типа.',
                          maxLines: 8,
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (step.subtitle != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Text(
                  step.subtitle!,
                  maxLines: 15,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            if (step.comment != null)
              Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xFFFD7F24).withOpacity(0.25),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.mode_comment,
                        color: Color(0xFFFF6B00),
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          S.of(context).makeReportPageAdminComment(
                                step.comment.toString(),
                              ),
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (step.type != ReviewTemplateStepType.info && step.type != ReviewTemplateStepType.form && step.multimedia != null)
              ContentTypeInfoWidget(
                multimedia: step.multimedia!,
                files: files,
                step: step,
              ),
            SizedBox(height: 12),
            if (step.type == ReviewTemplateStepType.form) ...[
              if (files.where((file) => file.stepId == step.localId && file.path == null && file.comment != null).isNotEmpty)
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: Color(0xFF0BB783),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.mode_comment,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            S.of(context).makeReportPageMissedWithComments(
                                  files.firstWhere((file) => file.stepId == step.localId && file.path == null && file.comment != null).comment.toString(),
                                ),
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: FormWidget(
                  isNeedToShowValidateResults: step.stepStatus == StepStatus.notValid,
                  form: step.form!,
                  initialRawForm: filesForStep.isNotEmpty
                      && File(filesForStep.first.path!).readAsStringSync().isNotEmpty
                      ? jsonDecode(File(filesForStep.first.path!).readAsStringSync())
                      : null,
                  onChange: (Map<String, dynamic> map) {
                    bloc.add(
                      SingleFormChangedEvent(
                        stepLocalId: step.localId!,
                        rawForm: map,
                      ),
                    );
                  },
                ),
              ),
            ] else if (step.type != ReviewTemplateStepType.info)
              ContentPreviewWidget(
                makeReportBloc: bloc,
                step: step,
                files: files,
                cacheStorageDir: cacheStorageDir,
              ),
            if (step.canHaveViolation && step.type != ReviewTemplateStepType.info) ...[
              CustomDivider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ViolationSwitch(
                  company: company,
                  step: step,
                  violations: state.violations.where((element) => element.stepId == step.localId).toList(),
                  review: state.review,
                  title: S.of(context).makeReportPageIssueOccured,
                ),
              ),
            ],
            if (state.template.expandable || step.expandable) ...[
              CustomDivider(),
              CheckBoxWithTitle(
                title: S.of(context).createAdditionalStep,
                onValueChanged: (value) {
                  bloc.add(AddStepCheckBoxValueChangedEvent(value));
                },
              ),
            ],
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
