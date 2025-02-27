import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_step_violation_repository.dart';
import 'package:leasing_company/main.dart';
import 'package:drift/drift.dart';

class ReviewStepViolationRepositoryImpl
    implements ReviewStepViolationRepository {
  Future<List<ReviewStepViolation>> getForReview(String reviewUuid) async {
    return (database.select(database.reviewStepViolations)
          ..where((tbl) => tbl.reviewUuid.equals(reviewUuid)))
        .get();
  }

  Future<ReviewStepViolation> create({
    required String companyUuid,
    required int stepId,
    required String reviewUuid,
  }) async {
    await database
        .into(database.reviewStepViolations)
        .insert(ReviewStepViolationsCompanion.insert(
          companyUuid: companyUuid,
          reviewUuid: reviewUuid,
          stepId: stepId,
        ));

    return (database.select(database.reviewStepViolations)
          ..where((tbl) =>
              tbl.companyUuid.equals(companyUuid) &
              tbl.reviewUuid.equals(reviewUuid) &
              tbl.stepId.equals(stepId)))
        .getSingle();
  }

  Future delete(
      {required String companyUuid,
      required String reviewUuid,
      required int stepId}) {
    return (database.delete(database.reviewStepViolations)
          ..where((tbl) =>
              tbl.companyUuid.equals(companyUuid) &
              tbl.reviewUuid.equals(reviewUuid) &
              tbl.stepId.equals(stepId)))
        .go();
  }

  Future deleteByReviewUuid(String reviewUuid) {
    return (database.delete(database.reviewStepViolations)
          ..where((tbl) => tbl.reviewUuid.equals(reviewUuid)))
        .go();
  }
}
