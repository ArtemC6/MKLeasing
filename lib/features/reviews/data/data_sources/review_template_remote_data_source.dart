import 'package:leasing_company/features/reviews/domain/models/review_template_mini_model.dart';

abstract class ReviewTemplateRemoteDataSource {
  Future<List<ReviewTemplateMiniModel>> getAll({
    required String companyUuid,
    required String type,
  });

  Future<bool> checkAvailability(int reviewTemplateId, String companyUuid);
}
