import 'package:equatable/equatable.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_model.dart';
import 'package:leasing_company/features/tasks/domain/models/task_model.dart';

abstract class TaskExecutionState extends Equatable {
  const TaskExecutionState();

  @override
  List<Object> get props => [];
}

class TaskExecutionInitial extends TaskExecutionState {}

class TaskExecutionReadyState extends TaskExecutionState {
  final CompanyEntity company;
  final TaskModel task;
  final ReviewTemplateModel template;
  final Review? review;

  TaskExecutionReadyState({
    required this.company,
    required this.task,
    required this.template,
    required this.review,
  });
}
