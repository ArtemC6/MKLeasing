import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:leasing_company/features/company/domain/use_cases/get_current_company.dart';
import 'package:leasing_company/features/tasks/domain/enums/task_accessed_by.dart';
import 'package:leasing_company/features/tasks/domain/enums/task_status.dart';
import 'package:leasing_company/features/tasks/domain/models/task_mini_model.dart';
import 'package:leasing_company/features/tasks/domain/use_cases/get_more_tasks.dart';
import 'package:leasing_company/main.dart';

import 'tasks_event.dart';
import 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final _getCurrentCompanyUseCase = getIt<GetCurrentCompany>();

  GetMoreTasksUseCase? getUserTasks;
  GetMoreTasksUseCase? getSubdivisionsTasks;

  List<TaskMiniModel> userTasks = [];
  List<TaskMiniModel> subdivisionsTasks = [];

  TaskStatus? currentStatusFilter;

  TasksBloc() : super(TasksInitial()) {
    on<TasksLoadEvent>(_onLoad);
    on<TasksLoadMoreEvent>(_onMore);
    on<TasksRefreshEvent>(_onRefresh);
    on<TasksChangeFilterEvent>(_onChangeFilter);
    // on<SearchEvent>(_search);
  }

  Future<void> _onLoad(TasksLoadEvent event, Emitter<TasksState> emit) async {
    if (!event.isRefresh) emit(TasksLoadInProgress());
    try {
      final currentCompany = await _getCurrentCompanyUseCase();
      if (currentCompany == null) {
        throw new Exception('Has not company');
      }

      getUserTasks = GetMoreTasksUseCase(GetMoreTasksParams(
        //todo need to move params from constructor to call method
        companyUuid: currentCompany.uuid,
        accessedBy: TaskAccessedBy.user,
        status: currentStatusFilter,
      ));

      getSubdivisionsTasks = GetMoreTasksUseCase(GetMoreTasksParams(
        //todo need to move params from constructor to call method
        companyUuid: currentCompany.uuid,
        accessedBy: TaskAccessedBy.subdivision,
        status: currentStatusFilter,
      ));

      await Future.wait([
        getUserTasks!.call().then((value) => userTasks = value!),
        getSubdivisionsTasks!
            .call()
            .then((value) => subdivisionsTasks = value!),
      ]);

      userTasks.sort((a, b) => a.status.index.compareTo(b.status.index));
      subdivisionsTasks.sort((a, b) => a.status.index.compareTo(b.status.index));
      event.refreshCompleter.complete();

      emit(
        TasksLoadSuccessState(
          userTasks: userTasks,
          subdivisionsTasks: subdivisionsTasks,
        ),
      );
    } catch (e) {
      print(e);
      emit(TasksLoadFail());
      // throw new Exception('Error with getting tasks');
    }
  }

  Future<void> _onRefresh(
      TasksRefreshEvent event, Emitter<TasksState> emit) async {
    add(TasksLoadEvent(event.refreshCompleter, isRefresh: true));
  }

  Future<void> _onChangeFilter(
      TasksChangeFilterEvent event, Emitter<TasksState> emit) async {
    currentStatusFilter = event.statusFilter;
    add(TasksLoadEvent(event.refreshCompleter));
  }

  // Future<void> _search(SearchEvent event, Emitter<TasksState> emit) async {}

  FutureOr<void> _onMore(
      TasksLoadMoreEvent event, Emitter<TasksState> emit) async {
    if (event.accessedBy == TaskAccessedBy.user &&
        getUserTasks?.hasNext() == true) {
      final tasks = (await getUserTasks!.call())!;
      userTasks.addAll(tasks);
    } else if (event.accessedBy == TaskAccessedBy.subdivision) {
      final tasks = (await getSubdivisionsTasks!.call())!;
      subdivisionsTasks.addAll(tasks);
    }

    event.refreshCompleter.complete();
    userTasks.sort((a, b) => a.status.index.compareTo(b.status.index));
    subdivisionsTasks.sort((a, b) => a.status.index.compareTo(b.status.index));
    emit(TasksLoadSuccessState(
      userTasks: userTasks,
      subdivisionsTasks: subdivisionsTasks,
    ));
  }
}
