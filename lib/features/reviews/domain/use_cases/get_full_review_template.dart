import 'package:leasing_company/features/reviews/domain/models/review_template_model.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_form_field_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_form_repository.dart';
import 'package:leasing_company/features/reviews/domain/use_cases/get_full_steps_for_review_template.dart';
import 'package:leasing_company/features/company/domain/use_cases/use_case.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_repository.dart';
import 'package:leasing_company/features/reviews/domain/use_cases/get_sections_for_review_template.dart';
import 'package:leasing_company/main.dart';

class GetFullReviewTemplate extends UseCase<ReviewTemplateModel, GetFullReviewTemplateParams> {
  ReviewTemplateRepository reviewTemplateRepository = getIt();
  ReviewTemplateStepRepository reviewTemplateStepRepository = getIt();
  ReviewTemplateStepFormRepository reviewTemplateStepFormRepository = getIt();
  ReviewTemplateStepFormFieldRepository reviewTemplateStepFormFieldRepository = getIt();

  @override
  Future<ReviewTemplateModel> call(GetFullReviewTemplateParams params) async {
    final template = (await reviewTemplateRepository.getByLocalId(params.localId))!;

    return template.copyWith(
      sections: await getIt<GetSectionsForReviewTemplate>().call(params.localId),
      steps: await getIt<GetFullStepsForReviewTemplate>().call(
        GetFullStepsForReviewTemplateParams(templateLocalId: params.localId),
      ),
    );
  }
}

class GetFullReviewTemplateParams {
  final String companyUuid;
  final int localId;

  GetFullReviewTemplateParams({
    required this.companyUuid,
    required this.localId,
  });
}
