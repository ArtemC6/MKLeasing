import 'package:flutter/widgets.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';
import 'package:leasing_company/features/tasks/presentation/task_execution/widgets/step_title.dart';

class InfoWidget extends StatelessWidget {
  final ReviewTemplateStepModel step;

  InfoWidget({Key? key, required this.step}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StepTitleWidget(step),
        if (step.subtitle != null)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(step.subtitle!),
          ),
        if (step.subtitle != null && step.contentText != null)
          Padding(padding: EdgeInsets.only(top: 15)),
      ],
    );
  }
}
