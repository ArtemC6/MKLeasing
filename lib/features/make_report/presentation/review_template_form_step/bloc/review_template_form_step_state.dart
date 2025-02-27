import 'package:leasing_company/core/drift/drift.dart';

abstract class ReviewTemplateFormStepState {}

class ReviewTemplateFormStepLoadInProgressState extends ReviewTemplateFormStepState {}

class ReviewTemplateFormStepReadyState extends ReviewTemplateFormStepState {
  final List<ReviewTemplateFormField> fields;

  ReviewTemplateFormStepReadyState({required this.fields});

  ReviewTemplateFormStepReadyState copy(){
    return ReviewTemplateFormStepReadyState(fields: fields);
  }
}
