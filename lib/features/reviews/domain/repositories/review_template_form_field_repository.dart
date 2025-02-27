import 'package:leasing_company/core/drift/drift.dart';

abstract class ReviewTemplateFormFieldRepository {
  Future<ReviewTemplateFormField?> getById(int id);

  Future<List<ReviewTemplateFormField>> getFieldsForForm(
      String companyUuid, int formId);

  Future<ReviewTemplateFormField> createCopyOf(int id, {int? formId});

  Future<ReviewTemplateFormField> create({
    required String type,
    required String companyUuid,
    required int remoteId,
    required String properties,
    required String title,
    required String slug,
    required int weight,
    required int formId,
    int? parentId,
  });
}
