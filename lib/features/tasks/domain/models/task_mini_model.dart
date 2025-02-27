import 'package:equatable/equatable.dart';
import 'package:leasing_company/features/tasks/domain/enums/task_priority.dart';
import 'package:leasing_company/features/tasks/domain/enums/task_status.dart';

class TaskMiniModel extends Equatable{
  final int id;
  final String title;
  final int? startExecutionAt;
  final int? finishExecutionAt;
  final TaskPriority priority;
  final TaskStatus status;
  final List<String> subdivisions;

  TaskMiniModel({
    required this.id,
    required this.title,
    required this.startExecutionAt,
    required this.finishExecutionAt,
    required this.priority,
    required this.status,
    required this.subdivisions,
  });

  factory TaskMiniModel.fromJson(Map<String, dynamic> json) {
    return TaskMiniModel(
      id: json['id'],
      title: json['title'],
      startExecutionAt: json['start_execution_at'],
      finishExecutionAt: json['finish_execution_at'],
      priority: TaskPriority.values.byName(json['priority']),
      status: TaskStatus.values.byName(json['status']),
      subdivisions: json['subdivisions'].cast<String>().toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'start_execution_at': startExecutionAt,
    'finish_execution_at': finishExecutionAt,
    'priority': priority,
    'status': status.value,
  };

  @override
  List<Object?> get props => [id];
}
