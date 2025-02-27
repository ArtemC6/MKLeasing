import 'package:leasing_company/core/drift/drift.dart';

abstract class ReviewStepViolationRepository {
  Future<List<ReviewStepViolation>> getForReview(String reviewUuid);

  Future<ReviewStepViolation> create({
    required String companyUuid,
    required int stepId,
    required String reviewUuid,
  });

  Future delete({
    required String companyUuid,
    required String reviewUuid,
    required int stepId,
  });

  Future deleteByReviewUuid(String reviewUuid);
}
