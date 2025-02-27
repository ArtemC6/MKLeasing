import 'package:equatable/equatable.dart';
import 'package:leasing_company/features/tasks/domain/models/task_mini_model.dart';
import 'package:uuid/uuid.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [Uuid().v4()];
}

class TasksInitial extends TasksState {}

class TasksLoadInProgress extends TasksState {}

class TasksLoadFail extends TasksState {}

class TasksLoadSuccessState extends TasksState {
  final List<TaskMiniModel> userTasks;
  final List<TaskMiniModel> subdivisionsTasks;

  TasksLoadSuccessState({
    required this.userTasks,
    required this.subdivisionsTasks,
  });
}
