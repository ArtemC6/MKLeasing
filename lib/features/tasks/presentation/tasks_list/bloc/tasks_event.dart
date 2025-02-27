import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:leasing_company/features/tasks/domain/enums/task_accessed_by.dart';
import 'package:leasing_company/features/tasks/domain/enums/task_status.dart';

abstract class TasksEvent extends Equatable {
  final Completer refreshCompleter;

  TasksEvent(this.refreshCompleter);

  @override
  List<Object> get props => [];
}

class TasksLoadEvent extends TasksEvent {
  final Completer refreshCompleter;
  final bool isRefresh;

  TasksLoadEvent(this.refreshCompleter, {this.isRefresh = false})
      : super(refreshCompleter);
}

class TasksRefreshEvent extends TasksEvent {
  final Completer refreshCompleter;

  TasksRefreshEvent(this.refreshCompleter) : super(refreshCompleter);
}

class TasksLoadMoreEvent extends TasksEvent {
  final Completer refreshCompleter;
  final TaskAccessedBy accessedBy;

  TasksLoadMoreEvent(this.refreshCompleter, this.accessedBy)
      : super(refreshCompleter);
}

class TasksChangeFilterEvent extends TasksEvent {
  final Completer refreshCompleter;
  final TaskStatus? statusFilter;

  TasksChangeFilterEvent(this.refreshCompleter, this.statusFilter)
      : super(refreshCompleter);
}
