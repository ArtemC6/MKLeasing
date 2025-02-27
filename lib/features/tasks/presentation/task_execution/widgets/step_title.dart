import 'package:flutter/material.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/core/presentation/widgets/black_bold_text.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_type.dart';
import 'package:leasing_company/features/tasks/presentation/task_execution/pages/task_execution_step_detail.dart';

class StepTitleWidget extends StatelessWidget {
  final ReviewTemplateStepModel step;
  final List<ReviewStepFile>? files;
  final double? titleFontSize;

  StepTitleWidget(this.step, {this.files, this.titleFontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(top: 2),
                child: BlackBoldText(
                  step.title,
                  withRedStar: step.required == true &&
                      step.type != ReviewTemplateStepType.info,
                  fontSize: titleFontSize,
                ),
              ),
            ),
            if (step.contentText != null || step.contentImage != null)
              IconButton(
                padding: EdgeInsets.only(left: 6),
                constraints: BoxConstraints(),
                icon: Icon(
                  Icons.info_outline,
                  color: Color(0xFF246BFD),
                  size: 24,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskExecutionStepDetail(step),
                  ),
                ),
              ),
          ]),
    );
  }
}
