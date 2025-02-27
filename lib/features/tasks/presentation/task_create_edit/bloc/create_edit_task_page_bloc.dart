import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/articles/domain/entities/article_mini_entity.dart';
import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/features/company/domain/use_cases/get_current_company.dart';
import 'package:leasing_company/features/reviews/domain/entities/review_template_mini_entity.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_mini_model.dart';
import 'package:leasing_company/features/tasks/domain/enums/task_priority.dart';
import 'package:leasing_company/features/tasks/domain/help_models/create_task_model.dart';
import 'package:leasing_company/features/tasks/domain/help_models/update_task_model.dart';
import 'package:leasing_company/features/tasks/domain/models/task_model.dart';
import 'package:leasing_company/features/tasks/domain/use_cases/create_task.dart';
import 'package:leasing_company/features/tasks/domain/use_cases/get_article_type_by_id.dart';
import 'package:leasing_company/features/tasks/domain/use_cases/get_articles_by_type.dart';
import 'package:leasing_company/features/tasks/domain/use_cases/get_articles_count_by_company.dart';
import 'package:leasing_company/features/tasks/domain/use_cases/get_list_review_templates.dart';
import 'package:leasing_company/features/tasks/domain/use_cases/get_task_by_id.dart';
import 'package:leasing_company/features/tasks/domain/use_cases/update_task.dart';
import 'package:leasing_company/main.dart';
import 'package:meta/meta.dart';

part 'create_edit_task_page_event.dart';
part 'create_edit_task_page_state.dart';

class CreateEditTaskPageBloc
    extends Bloc<CreateEditTaskPageEvent, CreateEditTaskPageState> {
  final _getCurrentCompanyUseCase = getIt<GetCurrentCompany>();
  final _reviewTemplateUseCase = getIt<GetListReviewTemplatesUseCase>();
  final _getTaskByIdUseCase = getIt<GetTaskByIdUseCase>();
  final _getArticlesByTypeUseCase = getIt<GetArticlesByTypeUseCase>();
  final _updateTaskUseCase = getIt<UpdateTaskUseCase>();
  final _createTaskUseCase = getIt<CreateTaskUseCase>();
  final _getArticleTypeByIdUseCase = getIt<GetArticleTypeByIdUseCase>();
  final _getArticlesCountByCompanyUseCase =
      getIt<GetArticlesCountByCompanyUseCase>();

  final int? _taskId;
  final Article? _article;
  TaskModel? task;
  CompanyEntity? _currentCompany;

  CreateEditTaskPageBloc(this._taskId, this._article)
      : super(CreateEditTaskPageState()) {
    on<InitEvent>(_onInitEvent);
    on<NeedSendForApprovalValueChangedEvent>(
        _onNeedSendForApprovalValueChangedEvent);
    on<ArticleChangedEvent>(_onArticleChangedEvent);
    on<ReviewTemplateChangedEvent>(_onReviewTemplateChangedEvent);
    on<UpdateUiEvent>(_onUpdateUiEvent);
    on<GetArticlesByTypeEvent>(_onGetArticlesByTypeEvent);
    on<SaveButtonPressedEvent>(_onSaveButtonPressedEvent);
    on<ShowValidateResults>(_onShowValidateResults);
    on<PriorityChangedEvent>(_onPriorityChangedEvent);
  }

  Future<void> _onInitEvent(_, Emitter<CreateEditTaskPageState> emit) async {
    _currentCompany ??= await _getCurrentCompanyUseCase();

    final count =
        await _getArticlesCountByCompanyUseCase(_currentCompany!.uuid);
    final bool hasArticles = count > 0;

    if (_taskId != null) {
      final task = await _getTaskByIdUseCase.call(
          GetTaskByIdParams(companyUuid: _currentCompany!.uuid, id: _taskId!));
      this.task = task;
      emit(state.copyWith(
          address: task.address,
          priority: task.priority,
          hasArticles: hasArticles,
          startExecutionAt: task.startExecutionAt != null
              ? DateTime.fromMillisecondsSinceEpoch(
                  task.startExecutionAt! * 1000)
              : null,
          finishExecutionAt: task.startExecutionAt != null
              ? DateTime.fromMillisecondsSinceEpoch(
                  task.finishExecutionAt! * 1000)
              : null,
          selectedArticle: ArticleMiniEntity(
            remoteId: task.article.remoteId,
            title: task.article.title,
          ),
          selectedReviewTemplate: ReviewTemplateMiniModel(
            remoteId: task.reviewTemplate.remoteId,
            name: task.reviewTemplate.name,
            articleTypeId: 0,
          )));
    } else {
      final listReviewTemplates =
          await _reviewTemplateUseCase.call(_currentCompany!.uuid);
      final CreateEditTaskPageState newState;
      if (_article != null) {
        final articleType = await _getArticleTypeByIdUseCase(_article!.typeId);
        newState = state.copyWith(
          currentCompany: _currentCompany,
          hasArticles: hasArticles,
          listReviewTemplates: listReviewTemplates
              .where(
                  (element) => element.articleTypeId == articleType?.remoteId)
              .toList(),
          selectedArticle: ArticleMiniEntity(
            remoteId: _article!.remoteId,
            title: _article!.title,
          ),
        );
      } else {
        newState = state.copyWith(
            currentCompany: _currentCompany,
            hasArticles: hasArticles, listReviewTemplates: listReviewTemplates);
      }
      emit(newState);
    }
  }

  void _onNeedSendForApprovalValueChangedEvent(_, Emitter emit) {
    emit(state.copyWith(isNeedSendToApproval: !state.isNeedSendToApproval));
  }

  FutureOr<void> _onArticleChangedEvent(
      ArticleChangedEvent event, Emitter emit) {
    emit(state.copyWith(selectedArticle: event.selectedArticle));
  }

  FutureOr<void> _onReviewTemplateChangedEvent(
      ReviewTemplateChangedEvent event, Emitter emit) {
    if (_article != null) {
      emit(
          state.copyWith(selectedReviewTemplate: event.selectedReviewTemplate));
    } else {
      emit(CreateEditTaskPageState(
        isNeedHideValidateResults: true,
        hasArticles: state.hasArticles,
        currentCompany: state.currentCompany,
        address: state.address,
        isNeedSendToApproval: state.isNeedSendToApproval,
        startExecutionAt: state.startExecutionAt,
        finishExecutionAt: state.finishExecutionAt,
        priority: state.priority,
        selectedArticle:
            state.selectedReviewTemplate != event.selectedReviewTemplate
                ? null
                : state.selectedArticle,
        selectedReviewTemplate: event.selectedReviewTemplate,
        listReviewTemplates: state.listReviewTemplates,
        listArticles:
            state.selectedReviewTemplate != event.selectedReviewTemplate
                ? null
                : state.listArticles,
        needPop: state.needPop,
        isButtonActive: state.isButtonActive,
      ));

      add(GetArticlesByTypeEvent(event.selectedReviewTemplate.articleTypeId));
    }
  }

  void _onUpdateUiEvent(_, Emitter emit) => emit(state);

  Future<void> _onGetArticlesByTypeEvent(GetArticlesByTypeEvent event,
      Emitter<CreateEditTaskPageState> emit) async {
    final listArticles = await _getArticlesByTypeUseCase(
        _currentCompany!.uuid, event.articleTypeId);
    emit(state.copyWith(listArticles: listArticles));
  }

  Future<void> _onSaveButtonPressedEvent(SaveButtonPressedEvent event, Emitter emit) async {
    emit(state.copyWith(isButtonActive: false));
    if (_taskId == null) {
      await _createTaskUseCase(
        CreateTaskModel(
          selectedArticleId: state.selectedArticle!.remoteId,
          selectedReviewTemplateId: state.selectedReviewTemplate!.remoteId,
          address: state.address,
          startExecutionAt: state.startExecutionAt,
          finishExecutionAt: state.finishExecutionAt,
          priority: state.priority,
          isNeedSendToApproval: state.isNeedSendToApproval,
        ),
        _currentCompany!.uuid,
      );
    } else {
      await _updateTaskUseCase(
        UpdateTaskModel(
          taskId: _taskId!,
          address: state.address,
          isNeedSendToApproval: state.isNeedSendToApproval,
          startExecutionAt: state.startExecutionAt,
          finishExecutionAt: state.finishExecutionAt,
          priority: state.priority,
        ),
        _currentCompany!.uuid,
      );
    }
    emit(state.copyWith(needPop: true, isButtonActive: true));
  }

  void _onShowValidateResults(_, Emitter emit) =>
      emit(state.copyWith(isNeedHideValidateResults: false));

  void _onPriorityChangedEvent(PriorityChangedEvent event, Emitter emit) {
    emit(state.copyWith(priority: event.selectedPriority));
  }
}
