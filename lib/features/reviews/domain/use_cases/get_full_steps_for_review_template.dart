import 'package:leasing_company/features/reviews/domain/models/review_template_step_form_model.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_form_field_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_form_repository.dart';
import 'package:leasing_company/features/company/domain/use_cases/use_case.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_repository.dart';

class GetFullStepsForReviewTemplate extends UseCase<
    List<ReviewTemplateStepModel>, GetFullStepsForReviewTemplateParams> {
  final ReviewTemplateRepository reviewTemplateRepository;
  final ReviewTemplateStepRepository reviewTemplateStepRepository;
  final ReviewTemplateStepFormRepository reviewTemplateStepFormRepository;
  final ReviewTemplateStepFormFieldRepository
      reviewTemplateStepFormFieldRepository;

  GetFullStepsForReviewTemplate(
    this.reviewTemplateRepository,
    this.reviewTemplateStepRepository,
    this.reviewTemplateStepFormRepository,
    this.reviewTemplateStepFormFieldRepository,
  );

  @override
  Future<List<ReviewTemplateStepModel>> call(
      GetFullStepsForReviewTemplateParams params) async {
    var steps = await reviewTemplateStepRepository
        .getByTemplateLocalId(params.templateLocalId);
    List<int> formLocalIds = steps
        .where((step) => step.formId != null)
        .map((step) => step.formId!)
        .toList();

    var forms =
        await reviewTemplateStepFormRepository.getByLocalIds(formLocalIds);

    var fields = await reviewTemplateStepFormFieldRepository
        .getByFormsLocalIds(formLocalIds);

    steps = steps.map((step) {
      ReviewTemplateStepFormModel? form;
      if (step.formId != null) {
        var formE = forms.firstWhere((form) => form.localId == step.formId);
        form = formE.copyWith(
            fields: fields.where((f) => f.formId == formE.localId).toList());
      }

      return step.copyWith(
        form: form,
      );
    }).toList();

    steps.sort((a, b) => a.weight.compareTo(b.weight));

    return steps;
  }
}

class GetFullStepsForReviewTemplateParams {
  final int templateLocalId;

  GetFullStepsForReviewTemplateParams({required this.templateLocalId});
}
