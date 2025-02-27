import 'package:leasing_company/features/reviews/domain/models/review_template_model.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_form_field_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_form_repository.dart';
import 'package:leasing_company/features/reviews/domain/use_cases/cache_review_template.dart';
import 'package:leasing_company/features/company/domain/use_cases/use_case.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_repository.dart';
import 'package:leasing_company/main.dart';

class CreateCopyOfReviewTemplate
    extends UseCase<int, CreateCopyOfReviewTemplateParams> {
  ReviewTemplateRepository reviewTemplateRepository = getIt();
  ReviewTemplateStepRepository reviewTemplateStepRepository = getIt();
  ReviewTemplateStepFormRepository reviewTemplateStepFormRepository = getIt();
  ReviewTemplateStepFormFieldRepository reviewTemplateStepFormFieldRepository = getIt();

  @override
  Future<int> call(CreateCopyOfReviewTemplateParams params) async {
    return await CacheReviewTemplate().call(CacheReviewTemplateParams(
      companyUuid: params.companyUuid,
      reviewTemplate: params.template.copyWith(),
    ));
  }
}

class CreateCopyOfReviewTemplateParams {
  final String companyUuid;
  final ReviewTemplateModel template;

  CreateCopyOfReviewTemplateParams({
    required this.companyUuid,
    required this.template,
  });
}
