import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:leasing_company/api/data_service.dart';
import 'package:leasing_company/features/company/domain/use_cases/get_current_company.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/articles/domain/repositories/article_repository.dart';
import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/features/main/domain/repositories/notification_repository.dart';
import 'package:leasing_company/features/main/presentation/enums/notification_status.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_repository.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';
import 'package:meta/meta.dart';

part 'create_review_event.dart';
part 'create_review_state.dart';


class CreateReviewBloc extends Bloc<CreateReviewEvent, CreateReviewState> {
  final _getCurrentCompanyUseCase = getIt<GetCurrentCompany>();
  final DataService dataService = getIt();
  final ArticleRepository articleRepository = getIt();
  final ReviewRepository reviewRepository = getIt();
  final ReviewTemplateRepository reviewTemplateRepository = getIt();
  final _notificationRepository = getIt<NotificationRepository>();
  CompanyEntity? _currentCompany;

  CreateReviewBloc() : super(CreateReviewState()) {
    on<InitialEvent>(_onInitialEvent);
    on<ArticleChangedEvent>(_onArticleChangedEvent);
    on<ReviewTemplateChangedEvent>(_onReviewTemplateChangedEvent);
    on<GetReviewTemplateForArticleEvent>(_onGetReviewTemplateForArticleEvent);
    on<ShowValidateResultsEvent>(_onShowValidateResultsEvent);
    on<OnCreatedReviewEvent>(_onCreatedReviewEvent);
  }

  Future<void> _onInitialEvent(InitialEvent event, Emitter emit) async {
    try {
      await dataService.syncAllData();
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
    }
    _currentCompany ??= await _getCurrentCompanyUseCase();

    if (_currentCompany == null) {
      emit(
        state.copyWith(
            errorMessage: event.localization.articlesScreenNeedToChooseCompany),
      );
      return;
    }

    final articles =
        await articleRepository.getListForCompany(_currentCompany!.uuid);
    emit(state.copyWith(
      listArticles: articles,
      currentCompany: _currentCompany,
    ));
  }

  void _onArticleChangedEvent(ArticleChangedEvent event, Emitter emit) {
    if (state.selectedReviewTemplate == null) {
      emit(state.copyWith(
        selectedArticle: event.selectedArticle,
        selectedReviewTemplate: state.selectedReviewTemplate,
      ));
    } else {
      emit(state.copyWith(
        isNeedHideValidateResults: true,
        selectedArticle: event.selectedArticle,
        selectedReviewTemplate:
            state.selectedArticle?.id != event.selectedArticle.id
                ? 'set null'
                : state.selectedReviewTemplate,
        listReviewTemplates: state.selectedArticle != event.selectedArticle
            ? 'set null'
            : state.listReviewTemplates,
      ));
    }
    add(GetReviewTemplateForArticleEvent());
  }

  void _onReviewTemplateChangedEvent(
      ReviewTemplateChangedEvent event, Emitter emit) {
    emit(state.copyWith(selectedReviewTemplate: event.selectedReviewTemplate));
  }

  Future<void> _onGetReviewTemplateForArticleEvent(_, Emitter emit) async {
    final templates = await reviewTemplateRepository.getList(
        _currentCompany!.uuid, state.selectedArticle!.id);
    final publicTemplates = templates.where((template) => !template.private)
        .toList();
    emit(state.copyWith(listReviewTemplates: publicTemplates));
  }

  void _onShowValidateResultsEvent(_, Emitter emit) {
    emit(state.copyWith(
      isNeedHideValidateResults: false,
    ));
  }
  Future<void> _onCreatedReviewEvent(OnCreatedReviewEvent event, Emitter emit)async{
    await _notificationRepository.saveLocalList(
        notificationStatus: LocalNotificationStatus.reportCreatedByUser,
        reviewOrTaskTitle: event.templateTitle,
        isReview: true,
        objectTitle: event.articleTitle);
  }
}
