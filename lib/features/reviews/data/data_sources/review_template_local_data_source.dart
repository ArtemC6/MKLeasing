import 'package:leasing_company/features/reviews/domain/models/review_template_model.dart';

abstract class ReviewTemplateLocalDataSource {
  Future<int> insert({
    required String companyUuid,
    required ReviewTemplateModel reviewTemplate,
  });

  Future<ReviewTemplateModel?> getByLocalId(int localId);

  Future<ReviewTemplateModel?> getByRemoteId(int remoteId, String companyUuid);
}
