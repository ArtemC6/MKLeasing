import 'package:equatable/equatable.dart';

abstract class TaskExecutionEvent extends Equatable {
  const TaskExecutionEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class TaskExecutionLoadEvent extends TaskExecutionEvent {}
