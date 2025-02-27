import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:leasing_company/features/reviews/domain/use_cases/cache_review_template.dart';
import 'package:leasing_company/features/company/domain/use_cases/get_current_company.dart';
import 'package:leasing_company/features/reviews/domain/use_cases/get_full_review_template.dart';
import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/features/tasks/domain/models/task_model.dart';
import 'package:leasing_company/features/tasks/domain/use_cases/get_started_review_for_task.dart';
import 'package:leasing_company/features/tasks/presentation/task_execution/bloc/task_execution.dart';
import 'package:leasing_company/main.dart';

class TaskExecutionBloc extends Bloc<TaskExecutionEvent, TaskExecutionState> {
  final TaskModel task;

  final _getCurrentCompanyUseCase = getIt<GetCurrentCompany>();
  final _getStartedReviewForTaskUseCase = getIt<GetStartedReviewForTaskUseCase>();

  CompanyEntity? _currentCompany;

  TaskExecutionBloc({required this.task}) : super(TaskExecutionInitial()) {
    on<TaskExecutionLoadEvent>(_onLoad);

    add(TaskExecutionLoadEvent());
  }

  Future<void> _onLoad(
      TaskExecutionLoadEvent event, Emitter<TaskExecutionState> emit) async {
    _currentCompany ??= await _getCurrentCompanyUseCase();

    final templateId =
        await CacheReviewTemplate().call(CacheReviewTemplateParams(
      companyUuid: _currentCompany!.uuid,
      reviewTemplate: task.reviewTemplate,
    ));

    final template =
        await GetFullReviewTemplate().call(GetFullReviewTemplateParams(
      companyUuid: _currentCompany!.uuid,
      localId: templateId,
    ));

    final review =
        await _getStartedReviewForTaskUseCase(GetStartedReviewForTaskParams(
      companyUuid: _currentCompany!.uuid,
      taskRemoteId: task.remoteId,
    ));

    emit(TaskExecutionReadyState(
      company: _currentCompany!,
      task: task,
      template: template,
      review: review,
    ));
  }
}
