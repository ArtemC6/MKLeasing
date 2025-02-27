import 'package:drift/drift.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_form_field_repository.dart';
import 'package:leasing_company/main.dart';

class ReviewTemplateFormFieldRepositoryImpl
    implements ReviewTemplateFormFieldRepository {
  Future<ReviewTemplateFormField?> getById(int id) async {
    return (database.select(database.reviewTemplateFormFields)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<List<ReviewTemplateFormField>> getFieldsForForm(
      String companyUuid, int formId) {
    return (database.select(database.reviewTemplateFormFields)
          ..where((tbl) =>
              tbl.companyUuid.equals(companyUuid) & tbl.formId.equals(formId)))
        .get();
  }

  Future<ReviewTemplateFormField> createCopyOf(int id, {int? formId}) async {
    var formField = (await getById(id))!;

    return create(
      type: formField.type,
      companyUuid: formField.companyUuid,
      remoteId: formField.remoteId,
      properties: formField.properties,
      title: formField.title,
      slug: formField.slug,
      weight: formField.weight,
      formId: formId ?? formField.id,
      parentId: formField.id,
    );
  }

  Future<ReviewTemplateFormField> create(
      {required String type,
      required String companyUuid,
      required int remoteId,
      required String properties,
      required String title,
      required String slug,
      required int weight,
      required int formId,
      int? parentId}) async {
    var id = await database
        .into(database.reviewTemplateFormFields)
        .insert(ReviewTemplateFormFieldsCompanion.insert(
          type: type,
          companyUuid: companyUuid,
          remoteId: remoteId,
          properties: properties,
          title: title,
          slug: slug,
          weight: weight,
          formId: formId,
          parentId: Value(parentId),
        ));

    return (await getById(id))!;
  }
}
