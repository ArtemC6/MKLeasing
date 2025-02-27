import 'package:leasing_company/features/make_report/presentation/make_report_page/models/step_status.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';

class StepModel extends ReviewTemplateStepModel {
  final StepStatus stepStatus;

  StepModel(
    ReviewTemplateStepModel _stepModel, {
    this.stepStatus = StepStatus.awaitingExecution,
  }) : super(
          localId: _stepModel.localId,
          remoteId: _stepModel.remoteId,
          remoteUuid: _stepModel.remoteUuid,
          parentId: _stepModel.parentId,
          companyUuid: _stepModel.companyUuid,
          reviewUuid: _stepModel.reviewUuid,
          templateId: _stepModel.templateId,
          title: _stepModel.title,
          subtitle: _stepModel.subtitle,
          contentText: _stepModel.contentText,
          contentImage: _stepModel.contentImage,
          contentMask: _stepModel.contentMask,
          comment: _stepModel.comment,
          required: _stepModel.required,
          expandable: _stepModel.expandable,
          repeatable: _stepModel.repeatable,
          canHaveViolation: _stepModel.canHaveViolation,
          weight: _stepModel.weight,
          type: _stepModel.type,
          formId: _stepModel.formId,
          form: _stepModel.form,
          requiredCommentWhenSkipping: _stepModel.requiredCommentWhenSkipping,
          multimedia: _stepModel.multimedia,
          isSelfCreated: _stepModel.isSelfCreated,
          sectionId: _stepModel.sectionId,
          localSectionId: _stepModel.localSectionId,
        );

  StepModel copyWithStepModel({
    StepStatus? stepStatus,
    ReviewTemplateStepModel? stepModel,
  }) {
    return StepModel(
      stepModel ?? this,
      stepStatus: stepStatus ?? this.stepStatus,
    );
  }
}
