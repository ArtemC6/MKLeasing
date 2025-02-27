import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/presentation/reviews_list/models/review_status.dart';

class ReviewModel extends ReviewTemplate {
  final Article article;
  final ReviewStatus status;
  final Review? review;

  ReviewModel({
    required this.article,
    required ReviewTemplate reviewTemplate,
    required this.status,
    required this.review,
  }) : super(
          id: reviewTemplate.id,
          remoteId: reviewTemplate.remoteId,
          companyUuid: reviewTemplate.companyUuid,
          name: reviewTemplate.name,
          expandable: reviewTemplate.expandable,
          repeatable: reviewTemplate.repeatable,
          isRework: reviewTemplate.isRework,
          private: reviewTemplate.private,
          rejectionAvailable: reviewTemplate.rejectionAvailable,
          delegationAvailable: reviewTemplate.delegationAvailable,
          simpleSignatureFile: reviewTemplate.simpleSignatureFile,
          simpleSignatureEnabled: reviewTemplate.simpleSignatureEnabled,
          isOpened: reviewTemplate.isOpened,
        );
}
