import 'package:leasing_company/features/reviews/domain/models/review_template_model.dart';
import 'package:leasing_company/features/reviews/domain/use_cases/get_full_steps_for_review_template.dart';
import 'package:leasing_company/features/company/domain/use_cases/use_case.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_repository.dart';
import 'package:leasing_company/features/reviews/domain/use_cases/get_sections_for_review_template.dart';
import 'package:leasing_company/main.dart';

class GetReviewTemplateByRemoteId extends UseCase<ReviewTemplateModel, GetReviewTemplateByRemoteIdParams> {
  final ReviewTemplateRepository reviewTemplateRepository = getIt();
  final ReviewTemplateStepRepository reviewTemplateStepRepository = getIt();

  @override
  Future<ReviewTemplateModel> call(GetReviewTemplateByRemoteIdParams params) async {
    return params.template.copyWith(
      sections: await getIt<GetSectionsForReviewTemplate>().call(params.template.localId!),
      steps: await getIt<GetFullStepsForReviewTemplate>().call(
        GetFullStepsForReviewTemplateParams(
          templateLocalId: params.template.remoteId,
        ),
      ),
    );
  }
}

class GetReviewTemplateByRemoteIdParams {
  final String companyUuid;
  final ReviewTemplateModel template;

  GetReviewTemplateByRemoteIdParams({
    required this.companyUuid,
    required this.template,
  });
}
