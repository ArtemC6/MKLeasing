import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/company/domain/use_cases/use_case.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_repository.dart';

class GetStartedReviewForTaskUseCase
    extends UseCase<Review?, GetStartedReviewForTaskParams> {
  final ReviewRepository reviewRepository;

  GetStartedReviewForTaskUseCase(this.reviewRepository);

  @override
  Future<Review?> call(GetStartedReviewForTaskParams params) {
    return reviewRepository.getForTaskRemoteId(
        params.companyUuid, params.taskRemoteId);
  }
}

class GetStartedReviewForTaskParams {
  final String companyUuid;
  final int taskRemoteId;

  GetStartedReviewForTaskParams({
    required this.companyUuid,
    required this.taskRemoteId,
  });
}
