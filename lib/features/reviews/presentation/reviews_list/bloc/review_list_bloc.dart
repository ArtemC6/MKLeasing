import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:leasing_company/api/data_service.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/articles/domain/repositories/article_repository.dart';
import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/features/company/domain/use_cases/get_current_company.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_repository.dart';
import 'package:leasing_company/features/reviews/presentation/reviews_list/models/review_model.dart';
import 'package:leasing_company/features/reviews/presentation/reviews_list/models/review_status.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/push_messaging_service.dart';
import 'package:meta/meta.dart';

part 'review_list_event.dart';

part 'review_list_state.dart';

class ReviewListBloc extends Bloc<ReviewListEvent, ReviewListState> {
  final GetCurrentCompany _getCurrentCompanyUseCase = getIt();
  final DataService _dataService = getIt();
  final ArticleRepository _articleRepository = getIt();
  final ReviewRepository _reviewRepository = getIt();
  final ReviewTemplateRepository _reviewTemplateRepository = getIt();
  late StreamSubscription<RemoteMessage> _pushMessagingStreamSubscription;

  int _filterIndex = 0;
  List<ReviewModel> reviewList = [];
  String _searchText = '';
  bool _isSearchShowing = false;
  CompanyEntity? _companyEntity;

  ReviewListBloc() : super(ReviewsInitialState()) {
    on<InitialEvent>(_onInitialEvent);
    on<FilterChangedEvent>(_onFilterChangedEvent);
    on<SearchTextChangedEvent>(_onSearchTextChangedEvent);
    on<SearchShowingModeChangedEvent>(_onSearchShowingModeChangedEvent);

    final pushMessagingService = getIt<PushMessagingService>();
    _pushMessagingStreamSubscription = pushMessagingService.controller.stream.listen((event) => add(InitialEvent()));
  }

  Future<void> _onInitialEvent(InitialEvent event, Emitter emit) async {
    try {
      emit(ReviewsInitialState());
      await _dataService.syncAllData();
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
    }
    _companyEntity = await _getCurrentCompanyUseCase();
    if (_companyEntity == null) {
      emit(ReviewsNeedToChooseCompanyState());
      return;
    }

    await _getReviewList();

    emit(ReviewsLoadSuccessState(
      reviews: _getFilteredReviews(),
      filterIndex: _filterIndex,
      searchText: _searchText,
      isSearchShowing: _isSearchShowing,
      companyEntity: _companyEntity!,
    ));
    event.completer?.complete();
  }

  Future<void> _getReviewList() async {
    final articles = await _articleRepository.getListForCompany(_companyEntity!.uuid);

    final reviews = await _reviewRepository.getInProgressReviews(_companyEntity!.uuid, articles.map((e) => e.remoteId).toList());

    final templates = (await _reviewTemplateRepository.getListForArticles(_companyEntity!.uuid, articles.map((e) => e.id).toList()))
        .where((element) => element.private)
        .toList();
    templates.sort((a, b) => a.remoteId.compareTo(b.remoteId));

    final templateToArticles = await _reviewTemplateRepository.getReviewTemplatesToArticlesList(_companyEntity!.uuid, articles.map((e) => e.id).toList());

    final List<ReviewModel> reviewModelsList = [];

    for (ReviewTemplate template in templates) {
      final articleId = templateToArticles.firstWhere((e) => e.templateId == template.id).articleId;

      final remoteArticleId = articles.firstWhere((article) => article.id == articleId).remoteId;

      final startedReviewsForTemplate = reviews.where((review) => template.remoteId == review.remoteTemplateId).toList();

      if (startedReviewsForTemplate.isEmpty) {
        reviewModelsList.add(ReviewModel(
          article: articles.where((article) => article.remoteId == remoteArticleId).first,
          reviewTemplate: template,
          status: template.isRework ? ReviewStatus.isRework : ReviewStatus.scheduled,
          review: null,
        ));
      }
    }

    for (Review review in reviews) {
      final reviewTemplate = await _reviewTemplateRepository.getById(_companyEntity!.uuid, review.templateId);
      if (reviewTemplate != null) {
        reviewModelsList.add(ReviewModel(
          article: articles.where((article) => article.remoteId == review.remoteArticleId).first,
          reviewTemplate: reviewTemplate,
          status: ReviewStatus.inWork,
          review: review,
        ));
      }
    }
    reviewList = reviewModelsList;
  }

  Future<void> notificationIsOpened(int remoteId) => _articleRepository.notificationIsOpened(remoteId: remoteId);

  Future<Map<InfoModal, List<ReviewModel>>> getModals() async {
    var mapData = {};

    await _getReviewList();

    final modals = await _articleRepository.getModals();
    mapData['review_request'] = reviewList.where((review) => review.status == ReviewStatus.scheduled).toList();
    mapData['review_rework'] = reviewList.where((review) => review.status == ReviewStatus.isRework).toList();
    return {
      modals.where((element) => element.type == 'review_request').first: mapData['review_request'],
      modals.where((element) => element.type == 'review_rework').first: mapData['review_rework'],
    };
  }

  void _onFilterChangedEvent(FilterChangedEvent event, Emitter emit) {
    _filterIndex = event.reviewStatus != null ? event.reviewStatus!.index + 1 : 0;
    if (state is ReviewsLoadSuccessState) {
      emit(ReviewsLoadSuccessState(
        reviews: _getFilteredReviews(),
        filterIndex: _filterIndex,
        searchText: _searchText,
        isSearchShowing: _isSearchShowing,
        companyEntity: _companyEntity!,
      ));
    }
  }

  @override
  Future<void> close() async {
    _pushMessagingStreamSubscription.cancel();
    return super.close();
  }

  void _onSearchTextChangedEvent(SearchTextChangedEvent event, Emitter emit) {
    _searchText = event.searchText.toLowerCase();
    if (state is ReviewsLoadSuccessState) {
      emit(ReviewsLoadSuccessState(
        reviews: _getFilteredReviews(),
        filterIndex: _filterIndex,
        searchText: _searchText,
        isSearchShowing: _isSearchShowing,
        companyEntity: _companyEntity!,
      ));
    }
  }

  List<ReviewModel> _getFilteredReviews() {
    List<ReviewModel> filteredReviews;
    if (_filterIndex == 1) {
      filteredReviews = reviewList.where((review) => review.status == ReviewStatus.scheduled).toList();
    } else if (_filterIndex == 2) {
      filteredReviews = reviewList.where((review) => review.status == ReviewStatus.inWork).toList();
    } else if (_filterIndex == 3) {
      filteredReviews = reviewList.where((review) => review.status == ReviewStatus.isRework).toList();
    } else
      filteredReviews = reviewList;
    filteredReviews.sort((a, b) => a.status.index.compareTo(b.status.index));
    return filteredReviews
        .where((reviewModel) =>
            (reviewModel.name.toLowerCase().contains(_searchText) || reviewModel.article.title.toLowerCase().contains(_searchText)) &&
            reviewModel.review?.finishedAt == null &&
            reviewModel.review?.interruptedAt == null)
        .toList();
  }

  void _onSearchShowingModeChangedEvent(_, Emitter emit) {
    if (state is ReviewsLoadSuccessState) {
      if (_isSearchShowing) _searchText = '';
      _isSearchShowing = !_isSearchShowing;
      emit(ReviewsLoadSuccessState(
        reviews: _getFilteredReviews(),
        filterIndex: _filterIndex,
        searchText: _searchText,
        isSearchShowing: _isSearchShowing,
        companyEntity: _companyEntity!,
      ));
    }
  }
}
