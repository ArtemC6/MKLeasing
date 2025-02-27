import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leasing_company/core/presentation/widgets/custom_counter_widget.dart';
import 'package:leasing_company/core/presentation/widgets/custom_outlined_button.dart';
import 'package:leasing_company/core/presentation/widgets/custom_text_field.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/models/step_model.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_dto.dart';
import 'package:leasing_company/generated/l10n.dart';

class ReviewCopyStepPage extends StatefulWidget {
  final StepModel step;

  const ReviewCopyStepPage({Key? key, required this.step}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReviewCopyStepPageState();
}

class _ReviewCopyStepPageState extends State<ReviewCopyStepPage> {
  bool isNeedToShowValidateResult = false;
  String stepName = '';
  int numberOfCopies = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          centerTitle: true,
          title: Text(S.of(context).copyingStep),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(children: [
                SvgPicture.asset(
                  'assets/icons/instruction.svg',
                  height: 26,
                  width: 26,
                ),
                SizedBox(width: 8),
                Text(
                  S.of(context).instruction,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ]),
              SizedBox(height: 10),
              Text(S.of(context).copyingStepInstruction),
              SizedBox(height: 16),
              Text(S.of(context).specifyNewStepName),
              SizedBox(height: 16),
              Text(
                S.of(context).addArticleScreenCompanyNameLabel,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              SizedBox(height: 6),
              CustomTextField(
                hintText: S.of(context).fillInTheField,
                maxLength: 150,
                isValueValid: isNeedToShowValidateResult ? stepName.isNotEmpty : true,
                isCounterVisible: true,
                onChanged: (value) {
                  setState(() {
                    stepName = value;
                  });
                },
              ),
              SizedBox(height: 16),
              Row(children: [
                Text(
                  S.of(context).numberOfCopies,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                Expanded(child: SizedBox()),
                CustomCounterWidget(
                  onChanged: (value) {
                    numberOfCopies = value;
                  },
                ),
                SizedBox(width: 20),
              ]),
              Expanded(child: SizedBox()),
              CustomOutlinedButton(
                  text: S.of(context).toNextStepButtonTitle,
                  backgroundColor: Color(0xFF246BFD),
                  onPressed: () {
                    if (stepName.isNotEmpty) {
                      createStepCopies(context);
                    } else {
                      setState(() {
                        isNeedToShowValidateResult = true;
                      });
                    }
                  }),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void createStepCopies(BuildContext context) {
    final listNewSteps = List.generate(
      numberOfCopies,
      (index) => ReviewTemplateStepDTO(
        title: stepName,
        type: widget.step.type.name,
        required: widget.step.required,
        expandable: widget.step.expandable,
        repeatable: widget.step.repeatable,
        canHaveViolation: widget.step.canHaveViolation,
        weight: 0,
        requiredCommentWhenSkipping: widget.step.requiredCommentWhenSkipping,
        multimedia: widget.step.multimedia,
        subtitle: widget.step.subtitle,
        comment: widget.step.comment,
        form: widget.step.form,
        formId: widget.step.formId,
        contentText: widget.step.contentText,
        contentImage: widget.step.contentImage,
        contentMask: widget.step.contentMask,
        sectionId: widget.step.sectionId,
        isSelfCreated: true,
        localSectionId: widget.step.localSectionId,
      ),
    );
    Navigator.of(context).pop(listNewSteps);
  }
}
