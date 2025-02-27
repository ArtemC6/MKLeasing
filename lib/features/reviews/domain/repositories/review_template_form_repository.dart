import 'package:leasing_company/core/drift/drift.dart';

abstract class ReviewTemplateFormRepository {
  Future<List<ReviewTemplateForm>> getFormsForSteps(
      String companyUuid, List<int> formsIds);

  Future<ReviewTemplateForm?> getById(int formId);

  Future<ReviewTemplateForm> create({
    required int remoteId,
    int? parentId,
    required String companyUuid,
    required String title,
    required String slug,
    required String? description,
  });

  Future<ReviewTemplateForm> createCopyOf(int formId);

  Future deleteByIds(List<int> formsIds);
}
