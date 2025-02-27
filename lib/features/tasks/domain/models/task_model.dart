import 'package:equatable/equatable.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_model.dart';
import 'package:leasing_company/features/tasks/domain/enums/task_priority.dart';
import 'package:leasing_company/features/tasks/domain/enums/task_status.dart';
import 'package:leasing_company/features/tasks/domain/models/article_model.dart';

class TaskModel extends Equatable {
  final int remoteId;
  final String title;
  final String? description;
  final int? startExecutionAt;
  final int? finishExecutionAt;
  final String? address;
  final TaskPriority priority;
  final TaskStatus status;
  final bool editable;
  final bool rejectable;
  final ArticleModel article;
  final String? comment;
  final ReviewTemplateModel reviewTemplate;

  TaskModel({
    required this.remoteId,
    required this.title,
    required this.description,
    required this.startExecutionAt,
    required this.finishExecutionAt,
    required this.address,
    required this.status,
    required this.priority,
    required this.editable,
    required this.rejectable,
    required this.article,
    required this.reviewTemplate,
    this.comment,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      remoteId: json['id'],
      title: json['title'],
      description: json['description'],
      startExecutionAt: json['start_execution_at'],
      finishExecutionAt: json['finish_execution_at'],
      address: json['address'],
      status: TaskStatus.values.byName(json['status']),
      priority: TaskPriority.values.byName(json['priority']),
      editable: json['editable'],
      rejectable: json['rejectable'],
      article: ArticleModel.fromJson(json['article']),
      reviewTemplate: ReviewTemplateModel.fromJson(json['review_template']),
      comment: json['comment'],
    );
  }

  @override
  List<Object?> get props => [remoteId];
}
