import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';
import 'package:leasing_company/features/tasks/presentation/task_execution/widgets/media/form.dart';
import 'package:leasing_company/features/tasks/presentation/task_execution/widgets/step_title.dart';

class FormWithTitle extends StatefulWidget {
  final ReviewTemplateStepModel step;
  final ReviewStepFile? file;
  final void Function(Map<String, dynamic>) onChange;
  final bool isNeedToShowValidateResults;

  const FormWithTitle({
    Key? key,
    required this.step,
    this.file,
    required this.onChange,
    this.isNeedToShowValidateResults = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => FormWithTitleState();
}

class FormWithTitleState extends State<FormWithTitle> {
  bool init = false;
  Map<String, dynamic>? initialRawForm;

  @override
  void initState() {
    if (widget.file != null) {
      initialRawForm = jsonDecode(File(widget.file!.path!).readAsStringSync());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      StepTitleWidget(widget.step, titleFontSize: 18),
      SizedBox(height: 10),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: FormWidget(
          form: widget.step.form!,
          isNeedToShowValidateResults: widget.isNeedToShowValidateResults,
          initialRawForm: initialRawForm,
          onChange: widget.onChange,
        ),
      ),
    ]);
  }
}
