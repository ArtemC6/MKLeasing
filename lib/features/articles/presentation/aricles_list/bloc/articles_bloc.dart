import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/api/data_service.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/features/company/domain/repositories/company_repository.dart';
import 'package:leasing_company/features/articles/domain/repositories/article_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_repository.dart';
import 'package:leasing_company/features/tasks/domain/use_cases/get_article_type_by_id.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/push_messaging_service.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'articles_event.dart';
import 'articles_state.dart';

class ArticlesListBloc extends Bloc<ArticlesListEvent, ArticlesListState> {
  final DataService dataService = getIt();
  final CompanyRepository companyRepository = getIt();
  final ArticleRepository articleRepository = getIt();
  final ReviewRepository reviewRepository = getIt();
  final ReviewTemplateRepository reviewTemplateRepository = getIt();
  final SharedPreferences sharedPreferences = getIt();

  final PushMessagingService pushMessagingService = getIt();
  late StreamSubscription<RemoteMessage> pushMessagingStreamSubscription;
  late StreamSubscription<CompanyEntity> companySubscription;

  List<Article> articles = [];
  bool _isSearchShowing = false;
  Article? article;

  ArticlesListBloc({this.article}) : super(ArticlesLoadInProgressState()) {
    on<ArticlesLoadEvent>(_onLoad);
    on<ArticlesRefreshEvent>(_onRefreshed);
    on<ArticleAddedEvent>(_onAdded);
    on<SearchArticlesEvent>(_onSearchArticlesEvent);
    on<SearchShowingModeChangedEvent>(_onSearchShowingModeChangedEvent);

    PushMessagingService pushMessagingService = getIt<PushMessagingService>();
    pushMessagingStreamSubscription = pushMessagingService.controller.stream.listen((event) => add(ArticlesLoadEvent()));

    companySubscription = companyRepository.controller.stream.listen((event) => add(ArticlesLoadEvent()));
    add(ArticlesLoadEvent());
  }

  Future<void> _onLoad(ArticlesLoadEvent event, Emitter<ArticlesListState> emit) async {
    try {
      //  emit(ArticlesLoadInProgressState());

      try {
        await dataService.syncAllData();
      } catch (e, stackTrace) {
        print(e);
        print(stackTrace);
      }
      final currentCompany = await companyRepository.getCurrent();

      if (currentCompany == null) {
        emit(ArticlesNeedToChooseCompanyState());
        return;
      }

      articles = await articleRepository.getListForCompany(currentCompany.uuid);

      final reviews = await reviewRepository.getForArticles(currentCompany.uuid, articles.map((e) => e.remoteId).toList());

      final templates = await reviewTemplateRepository.getListForArticles(currentCompany.uuid, articles.map((e) => e.id).toList());

      final templatesToArticles = await reviewTemplateRepository.getReviewTemplatesToArticlesList(
        currentCompany.uuid,
        articles.map((e) => e.id).toList(),
      );

      final properties = await articleRepository.getProperties();

      emit(ArticlesLoadSuccessState(
        currentCompany: currentCompany,
        articles: articles,
        reviews: reviews,
        templates: templates,
        isSearchShowing: _isSearchShowing,
        templatesToArticles: templatesToArticles,
        properties: properties,
        // articleType: articleType,
      ));
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(ArticlesLoadFailureState());
    }
  }

  Future<void> _onRefreshed(ArticlesRefreshEvent event, Emitter<ArticlesListState> emit) async {
    try {
      emit(ArticlesLoadInProgressState());
      try {
        await dataService.syncAllData();
      } catch (e, stackTrace) {
        print(e);
        print(stackTrace);
      }
      final currentCompany = await companyRepository.getCurrent();
      if (currentCompany == null) {
        emit(ArticlesNeedToChooseCompanyState());
        return;
      }

      articles = await articleRepository.getListForCompany(currentCompany.uuid);

      final reviews = await reviewRepository.getForArticles(currentCompany.uuid, articles.map((e) => e.remoteId).toList());

      final templates = await reviewTemplateRepository.getListForArticles(currentCompany.uuid, articles.map((e) => e.id).toList());

      final properties = await articleRepository.getProperties();

      final templatesToArticles = await reviewTemplateRepository.getReviewTemplatesToArticlesList(
        currentCompany.uuid,
        articles.map((e) => e.id).toList(),
      );

      emit(ArticlesLoadSuccessState(
        currentCompany: currentCompany,
        articles: articles
            .where((element) =>
                element.title.toLowerCase().contains(state is ArticlesLoadSuccessState ? (state as ArticlesLoadSuccessState).searchText.toLowerCase() : ''))
            .toList(),
        reviews: reviews,
        templates: templates,
        searchText: state is ArticlesLoadSuccessState ? (state as ArticlesLoadSuccessState).searchText : '',
        isSearchShowing: _isSearchShowing,
        templatesToArticles: templatesToArticles,
        properties: properties,
      ));
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(ArticlesLoadFailureState());
    }
    if (!event.refreshCompleter.isCompleted) {
      event.refreshCompleter.complete();
    }
  }

  Future<void> _onAdded(ArticleAddedEvent event, Emitter<ArticlesListState> emit) async {
    if (state is ArticlesLoadSuccessState) {
      add(ArticlesLoadEvent());
    }
  }

  @override
  Future<void> close() async {
    pushMessagingStreamSubscription.cancel();
    companySubscription.cancel();
    return super.close();
  }

  void _onSearchArticlesEvent(SearchArticlesEvent event, Emitter emit) {
    if (state is ArticlesLoadSuccessState) {
      final currentState = state as ArticlesLoadSuccessState;
      emit(ArticlesLoadSuccessState(
        isSearchShowing: _isSearchShowing,
        articles: articles.where((element) => element.title.toLowerCase().contains(event.searchText.toLowerCase())).toList(),
        searchText: event.searchText,
        currentCompany: currentState.currentCompany,
        templates: currentState.templates,
        reviews: currentState.reviews,
        templatesToArticles: currentState.templatesToArticles,
      ));
    }
  }

  void _onSearchShowingModeChangedEvent(SearchShowingModeChangedEvent event, Emitter<ArticlesListState> emit) {
    if (state is ArticlesLoadSuccessState) {
      _isSearchShowing = !_isSearchShowing;
      final currentState = state as ArticlesLoadSuccessState;
      emit(ArticlesLoadSuccessState(
        isSearchShowing: _isSearchShowing,
        articles: articles,
        searchText: '',
        currentCompany: currentState.currentCompany,
        templates: currentState.templates,
        reviews: currentState.reviews,
        templatesToArticles: currentState.templatesToArticles,
      ));
    }
  }
}
