import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

abstract class TaskDetailEvent extends Equatable {
  const TaskDetailEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [Uuid().v4()];
}

class TaskDetailLoadEvent extends TaskDetailEvent {}

class TaskDetailTakeAtWorkEvent extends TaskDetailEvent {
  final int id;
  final String reviewOrTaskTitle;
  final String objectTitle;

  TaskDetailTakeAtWorkEvent(
      {required this.id,
      required this.reviewOrTaskTitle,
      required this.objectTitle});
}

class TaskDetailRefuseEvent extends TaskDetailEvent {
  final int id;
  final String reviewOrTaskTitle;
  final String objectTitle;

  TaskDetailRefuseEvent(
      {required this.id,
      required this.reviewOrTaskTitle,
      required this.objectTitle});
}
