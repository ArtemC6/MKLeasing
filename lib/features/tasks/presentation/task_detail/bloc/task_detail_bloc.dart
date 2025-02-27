import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/features/company/domain/use_cases/get_current_company.dart';
import 'package:leasing_company/features/main/domain/repositories/notification_repository.dart';
import 'package:leasing_company/features/main/presentation/enums/notification_status.dart';
import 'package:leasing_company/features/tasks/domain/enums/task_status.dart';
import 'package:leasing_company/features/tasks/domain/models/task_model.dart';
import 'package:leasing_company/features/tasks/domain/use_cases/change_status.dart';
import 'package:leasing_company/features/tasks/domain/use_cases/get_started_review_for_task.dart';
import 'package:leasing_company/features/tasks/domain/use_cases/get_task_by_id.dart';
import 'package:leasing_company/features/tasks/presentation/task_detail/bloc/task_detail.dart';
import 'package:leasing_company/main.dart';

class TaskDetailBloc extends Bloc<TaskDetailEvent, TaskDetailState> {
  final int taskId;
  CompanyEntity? currentCompany;
  final _getTaskByIdUseCase = getIt<GetTaskByIdUseCase>();
  final _getCurrentCompanyUseCase = getIt<GetCurrentCompany>();
  final _changeStatusUseCase = getIt<ChangeStatusUseCase>();
  final _getStartedReviewForTaskUseCase =
      getIt<GetStartedReviewForTaskUseCase>();
  final _notificationRepository = getIt<NotificationRepository>();

  TaskDetailBloc({required this.taskId}) : super(TaskDetailLoadInProgress()) {
    on<TaskDetailTakeAtWorkEvent>(_onTakeAtWork);
    on<TaskDetailRefuseEvent>(_onRefuse);
    on<TaskDetailLoadEvent>(_onLoad);

    add(TaskDetailLoadEvent());
  }

  Future<void> _onLoad(
      TaskDetailLoadEvent event, Emitter<TaskDetailState> emit) async {
    emit(TaskDetailLoadInProgress());

    currentCompany ??= await _getCurrentCompanyUseCase();
    if (currentCompany == null) {
      // emit(ArticlesNeedToChooseCompanyState(companies));
      throw new Exception('Has not company');
    }

    TaskModel task = await _getTaskByIdUseCase(GetTaskByIdParams(
      companyUuid: currentCompany!.uuid,
      id: taskId,
    ));

    final review =
        await _getStartedReviewForTaskUseCase(GetStartedReviewForTaskParams(
      companyUuid: currentCompany!.uuid,
      taskRemoteId: task.remoteId,
    ));

    emit(TaskDetailReadyState(
        task: task,
        canExecute: review != null ? review.finishedAt == null : true,
        isTaskExecutionStarted: review != null));
  }

  Future<void> _onTakeAtWork(
      TaskDetailTakeAtWorkEvent event, Emitter<TaskDetailState> emit) async {
    bool success = await _changeStatusUseCase(ChangeStatusParams(
      companyUuid: currentCompany!.uuid,
      id: taskId,
      status: TaskStatus.at_work,
    ));

    if (!success) {
      throw new Exception('Cant take at work task');
    } else {
      await _notificationRepository.saveLocalList(
          notificationStatus: LocalNotificationStatus.gotToWork,
          reviewOrTaskTitle: event.reviewOrTaskTitle,
          isReview: false,
          objectTitle: event.objectTitle);
    }
    add(TaskDetailLoadEvent());
  }

  Future<void> _onRefuse(
      TaskDetailRefuseEvent event, Emitter<TaskDetailState> emit) async {
    bool success = await _changeStatusUseCase(ChangeStatusParams(
      companyUuid: currentCompany!.uuid,
      id: taskId,
      status: TaskStatus.rejected,
    ));

    if (!success) {
      throw new Exception('Cant refuse task');
    }
    add(TaskDetailLoadEvent());
  }
}
