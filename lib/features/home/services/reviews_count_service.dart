import 'dart:async';

import 'package:leasing_company/features/company/domain/use_cases/get_current_company.dart';
import 'package:leasing_company/features/articles/domain/repositories/article_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_repository.dart';
import 'package:leasing_company/main.dart';
import 'package:rxdart/subjects.dart';

class ReviewsCountService {
  final GetCurrentCompany _getCurrentCompanyUseCase = getIt();
  final ArticleRepository _articleRepository = getIt();
  final ReviewRepository _reviewRepository = getIt();
  final ReviewTemplateRepository _reviewTemplateRepository = getIt();

  StreamController<int> _reviewsCountStreamController = BehaviorSubject<int>();

  Stream<int> get reviewsCountStream => _reviewsCountStreamController.stream;

  Future<void> updateData() async {
    int reviewsCount = 0;

    final _companyEntity = await _getCurrentCompanyUseCase();
    if (_companyEntity == null) {
      _reviewsCountStreamController.add(reviewsCount);
      return;
    }

    final articles =
        await _articleRepository.getListForCompany(_companyEntity.uuid);

    final reviews = await _reviewRepository.getInProgressReviews(
        _companyEntity.uuid, articles.map((e) => e.remoteId).toList());

    final notFinishedReviews = reviews
        .where((review) =>
            review.finishedAt == null && review.interruptedAt == null)
        .toList();

    final templates = (await _reviewTemplateRepository.getListForArticles(
            _companyEntity.uuid, articles.map((e) => e.id).toList()))
        .where((template) =>
            template.private &&
            reviews
                .where((review) => template.remoteId == review.remoteTemplateId)
                .isEmpty)
        .toList();

    reviewsCount += templates.length;
    reviewsCount += notFinishedReviews.length;

    _reviewsCountStreamController.add(reviewsCount);
  }
}
