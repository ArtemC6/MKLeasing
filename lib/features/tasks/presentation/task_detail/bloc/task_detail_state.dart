import 'package:equatable/equatable.dart';
import 'package:leasing_company/features/tasks/domain/models/task_model.dart';
import 'package:uuid/uuid.dart';

abstract class TaskDetailState extends Equatable {
  const TaskDetailState();

  @override
  List<Object> get props => [Uuid().v4()];
}

class TaskDetailLoadInProgress extends TaskDetailState {}

class TaskDetailReadyState extends TaskDetailState {
  final TaskModel task;
  final bool canExecute;
  final bool isTaskExecutionStarted;

  TaskDetailReadyState({
    required this.task,
    required this.canExecute,
    required this.isTaskExecutionStarted,
  });
}
