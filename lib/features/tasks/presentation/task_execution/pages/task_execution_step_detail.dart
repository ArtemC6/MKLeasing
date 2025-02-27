import 'package:flutter/material.dart';
import 'package:leasing_company/core/presentation/widgets/black_bold_text.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';
import 'package:leasing_company/generated/l10n.dart';

class TaskExecutionStepDetail extends StatelessWidget {
  final ReviewTemplateStepModel step;

  TaskExecutionStepDetail(this.step);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          step.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: ListView(padding: EdgeInsets.symmetric(horizontal: 35), children: [
        SizedBox(height: 30),
        if (step.contentImage != null) ...[
          BlackBoldText(S.of(context).taskExecutionStepDetailPhotoExampleTitle,
              withRedStar: false),
          SizedBox(height: 10),
          // NetworkImage(step.contentImage!)

          Container(
              margin: EdgeInsets.only(bottom: 30),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  // color: Color(0xffCDCDCD),
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Image.network(
                  step.contentImage!,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              )),
        ],
        if (step.contentText != null) ...[
          BlackBoldText(
            S.of(context).taskExecutionStepDetailDescriptionTitle,
            withRedStar: false,
          ),
          SizedBox(height: 10),
          Text(step.contentText!)
        ],
      ]),
    );
  }
}
