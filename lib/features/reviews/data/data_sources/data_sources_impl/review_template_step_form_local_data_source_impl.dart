import 'package:drift/drift.dart';
import 'package:leasing_company/features/reviews/data/data_sources/review_template_step_form_local_data_source.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_form_model.dart';
import 'package:leasing_company/main.dart';

class ReviewTemplateStepFormLocalDataSourceImpl
    implements ReviewTemplateStepFormLocalDataSource {
  Future<int> insert(String companyUuid, int localTemplateId,
      ReviewTemplateStepFormModel form) {
    return database
        .into(database.reviewTemplateForms)
        .insert(ReviewTemplateFormsCompanion.insert(
          remoteId: form.remoteId,
          parentId: Value(form.parentId),
          title: form.title,
          description: Value(form.description),
          slug: form.slug,
          companyUuid: companyUuid,
        ));
  }

  Future<ReviewTemplateStepFormModel?> getByLocalId(
      String companyUuid, int localId) async {
    ReviewTemplateForm? form =
        await (database.select(database.reviewTemplateForms)
              ..where((tbl) =>
                  tbl.id.equals(localId) & tbl.companyUuid.equals(companyUuid)))
            .getSingleOrNull();

    if (form == null) return null;

    return ReviewTemplateStepFormModel.fromDBModel(form);
  }

  Future<List<ReviewTemplateStepFormModel>> getByLocalIds(
      List<int> stepsIdsWithForms) async {
    var forms = await (database.select(database.reviewTemplateForms)
          ..where((tbl) => tbl.id.isIn(stepsIdsWithForms)))
        .get();

    return forms
        .map((step) => ReviewTemplateStepFormModel.fromDBModel(step))
        .toList();
  }
}
