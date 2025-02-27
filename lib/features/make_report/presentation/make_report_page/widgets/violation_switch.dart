import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_step_violation_repository.dart';
import 'package:leasing_company/main.dart';


class ViolationSwitch extends StatefulWidget {
  final CompanyEntity company;
  final ReviewTemplateStepModel step;
  final List violations;
  final Review review;
  final String title;

  ViolationSwitch({
    Key? key,
    required this.company,
    required this.step,
    required this.violations,
    required this.review,
    required this.title,
  }) : super(key: key);

  @override
  State<ViolationSwitch> createState() => _ViolationSwitchState();
}

class _ViolationSwitchState extends State<ViolationSwitch> {
  final reviewStepViolationRepository = getIt<ReviewStepViolationRepository>();
  late bool isHaveViolations = widget.violations.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15.0,
              color: Colors.black,
            ),
          ),
          Transform.scale(
              scale: 0.85,
              child: CupertinoSwitch(
                  activeColor: Color(0xFF246BFD),
                  value: isHaveViolations,
                  onChanged: (value) async {
                    await onChanged(value, context);
                  }),
            ),
        ],
      ),
    );
  }

  Future<void> onChanged(bool value, BuildContext context) async {
    setState(() {
      isHaveViolations = value;
    });
    if (value) {
      await reviewStepViolationRepository.create(
        companyUuid: widget.company.uuid,
        reviewUuid: widget.review.uuid,
        stepId: widget.step.localId!,
      );
    } else {
      await reviewStepViolationRepository.delete(
        companyUuid: widget.company.uuid,
        reviewUuid: widget.review.uuid,
        stepId: widget.step.localId!,
      );
    }
  }
}
