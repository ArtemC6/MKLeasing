import 'package:drift/drift.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_form_field_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_form_repository.dart';
import 'package:leasing_company/main.dart';

class ReviewTemplateFormRepositoryImpl implements ReviewTemplateFormRepository{
  Future<List<ReviewTemplateForm>> getFormsForSteps(

      String companyUuid, List<int> formsIds) {
    return (database.select(database.reviewTemplateForms)
          ..where((tbl) =>
              tbl.companyUuid.equals(companyUuid) & tbl.id.isIn(formsIds)))
        .get();
  }

  Future<ReviewTemplateForm?> getById(int formId) {
    return (database.select(database.reviewTemplateForms)
          ..where((tbl) => tbl.id.equals(formId)))
        .getSingleOrNull();
  }

  Future<ReviewTemplateForm> create({
    required int remoteId,
    int? parentId,
    required String companyUuid,
    required String title,
    required String slug,
    required String? description,
  }) async {
    final id = await database.into(database.reviewTemplateForms).insert(
        ReviewTemplateFormsCompanion.insert(
            parentId: Value(parentId),
            remoteId: remoteId,
            companyUuid: companyUuid,
            title: title,
            slug: slug,
            description: Value(description)));

    return (await getById(id))!;
  }

  Future<ReviewTemplateForm> createCopyOf(int formId) async {
    final form = (await getById(formId))!;

    final newForm = await create(
        remoteId: form.remoteId,
        parentId: form.id,
        companyUuid: form.companyUuid,
        title: form.title,
        slug: form.slug,
        description: form.description);

    final reviewTemplateFormFieldRepository =
        getIt<ReviewTemplateFormFieldRepository>();

    final formFields = await reviewTemplateFormFieldRepository.getFieldsForForm(
        form.companyUuid, form.id);

    final futures = formFields.map((e) => reviewTemplateFormFieldRepository
        .createCopyOf(e.id, formId: newForm.id));

    await Future.wait(futures);

    return newForm;
  }

  Future deleteByIds(List<int> formsIds) {
    return (database.delete(database.reviewTemplateForms)
          ..where((tbl) => tbl.id.isIn(formsIds)))
        .go();
  }
}
