import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/api/ReviewService.dart';
import 'package:leasing_company/core/config/repositories/config_repository.dart';
import 'package:leasing_company/features/company/domain/repositories/company_repository.dart';
import 'package:leasing_company/features/articles/domain/repositories/article_repository.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_model.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_proxy.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_repository.dart';
import 'package:leasing_company/features/reviews/presentation/choose_review_template/bloc/choose_review_template_event.dart';
import 'package:leasing_company/features/reviews/presentation/choose_review_template/bloc/choose_review_template_state.dart';
import 'package:leasing_company/main.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ChooseReviewTemplateBloc
    extends Bloc<ChooseReviewTemplateEvent, ChooseReviewTemplateState> {
  final Article article;
  final ReviewTemplateRepository reviewTemplateRepository = getIt();
  final ReviewRepository reviewRepository = getIt();
  final ReviewService reviewService = getIt();
  final ArticleRepository articleRepository = getIt();
  final ConfigRepository configRepository = getIt();
  final CompanyRepository companyRepository = getIt();

  ChooseReviewTemplateBloc({required this.article})
      : super(ChooseReviewTemplateLoadInProgressState()) {
    on<ChooseReviewTemplateLoadEvent>(_mapLoadToState);

    add(ChooseReviewTemplateLoadEvent());
  }

  Future<void> _mapLoadToState(ChooseReviewTemplateLoadEvent event,
      Emitter<ChooseReviewTemplateState> emit) async {
    try {
      emit(ChooseReviewTemplateLoadInProgressState());

      final company = await companyRepository.getCurrent();

      List<ReviewTemplate> templates = await reviewTemplateRepository.getList(
          article.companyUuid, article.id);

      List<Review> reviews =
          (await reviewRepository.getInProgressByRemoteArticleId(
                  article.companyUuid, article.remoteId))
              .where((element) => element.remoteTaskId == null)
              .toList();

      List<int> reviewsTemplatesIds = reviews.map((e) => e.templateId).toList();

      List<ReviewTemplate> reviewsTemplates =
          await reviewTemplateRepository.getListByIds(
        companyUuid: article.companyUuid,
        reviewsTemplatesIds: reviewsTemplatesIds,
      );

      templates.removeWhere((t) =>
          t.private == true &&
          reviewsTemplates.where((rt) => rt.remoteId == t.remoteId).length > 0);

      List<ReviewTemplateProxy> articleTemplatesProxies = [];

      articleTemplatesProxies.addAll(templates.map((template) =>
          ReviewTemplateProxy(
              template: ReviewTemplateModel.fromDBModel(template))));

      articleTemplatesProxies.addAll(reviews.map((review) =>
          ReviewTemplateProxy(
              template: ReviewTemplateModel.fromDBModel(reviewsTemplates
                  .firstWhere((element) => element.id == review.templateId)),
              review: review)));

      articleTemplatesProxies
          .sort((a, b) => a.template.private == true ? -1 : 1);

      emit(ChooseReviewTemplateLoadSuccessState(
        company: company!,
        config: this.configRepository.config!,
        articleTemplatesProxies: articleTemplatesProxies,
      ));
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(ChooseReviewTemplateLoadFailureState());
    }
  }
}
