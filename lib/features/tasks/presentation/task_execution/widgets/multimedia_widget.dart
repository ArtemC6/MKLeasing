import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/bloc/make_report_bloc.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/content_preview/content_preview.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/content_preview/content_type_info_widget.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_multimedia_model.dart';
import 'package:leasing_company/features/tasks/presentation/task_execution/widgets/step_title.dart';

class MultimediaWidget extends StatelessWidget {
  final List<ReviewTemplateStepMultimediaModel> multimedia;
  final ReviewTemplateStepModel step;
  final List<ReviewStepFile> stepFiles;
  final String cacheStorageDir;

  const MultimediaWidget({
    Key? key,
    required this.multimedia,
    required this.step,
    required this.stepFiles,
    required this.cacheStorageDir,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      StepTitleWidget(step, files: stepFiles),
      if (step.subtitle != null)
        Padding(
            padding: EdgeInsets.only(
              top: 8,
              left: 16,
              right: 16,
            ),
            child: Text(
              step.subtitle!,
              style: TextStyle(fontSize: 14),
            )),
      ContentTypeInfoWidget(
        multimedia: step.multimedia!,
        step: step,
        files: stepFiles,
      ),
      if (stepFiles.isNotEmpty)
        ContentPreviewWidget(
          makeReportBloc: context.read<MakeReportBloc>(),
          step: step,
          files: stepFiles,
          cacheStorageDir: cacheStorageDir,
        ),
      SizedBox(height: stepFiles.isEmpty? 16 : 8),
    ]);
  }
}
