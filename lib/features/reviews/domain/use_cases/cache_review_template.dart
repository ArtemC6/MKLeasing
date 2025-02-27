import 'package:drift/drift.dart';
import 'package:leasing_company/features/company/domain/use_cases/use_case.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_model.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_section_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_form_field_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_form_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_repository.dart';
import 'package:leasing_company/main.dart';

class CacheReviewTemplate extends UseCase<int, CacheReviewTemplateParams> {
  final ReviewTemplateRepository reviewTemplateRepository = getIt();
  final ReviewTemplateStepRepository reviewTemplateStepRepository = getIt();
  final ReviewTemplateStepFormRepository reviewTemplateStepFormRepository =
      getIt();
  final ReviewTemplateStepFormFieldRepository
      reviewTemplateStepFormFieldRepository = getIt();
  final ReviewTemplateSectionRepository reviewTemplateSectionRepository =
      getIt();

  Future<int> call(CacheReviewTemplateParams params) async {
    var reviewTemplateLocalId = await reviewTemplateRepository.insert(
        params.companyUuid,
        params.reviewTemplate
            .copyWith(parentId: params.reviewTemplate.localId));

    final futures = params.reviewTemplate.steps!.map((step) async {
      int? localFormId;
      if (step.form != null) {
        localFormId = await reviewTemplateStepFormRepository.insert(
            params.companyUuid,
            reviewTemplateLocalId,
            step.form!.copyWith(parentId: step.form!.localId));

        List<Future> futures = step.form!.fields!.map((field) async {
          return await reviewTemplateStepFormFieldRepository.insert(
              params.companyUuid,
              localFormId!,
              field.copyWith(parentId: field.localId));
        }).toList();

        await Future.wait(futures);
      }
      return await reviewTemplateStepRepository.insert(step.copyWith(
        parentId: step.localId,
        companyUuid: params.companyUuid,
        templateId: reviewTemplateLocalId,
        formId: localFormId,
      ));
    });
    await Future.wait(futures);

    final sectionsFutures = params.reviewTemplate.sections?.map((e) async {
      return reviewTemplateSectionRepository.insert(e.copyWith(
        templateId: reviewTemplateLocalId,
        parentId: Value(e.remoteId),
      ));
    });
    if (sectionsFutures != null) {
      await Future.wait(sectionsFutures);
    }

    return reviewTemplateLocalId;
  }
}

class CacheReviewTemplateParams {
  String companyUuid;
  ReviewTemplateModel reviewTemplate;

  CacheReviewTemplateParams({
    required this.companyUuid,
    required this.reviewTemplate,
  });
}
