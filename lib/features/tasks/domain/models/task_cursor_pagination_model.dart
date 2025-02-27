import 'package:leasing_company/features/tasks/domain/entities/cursor_pagination_entity.dart';
import 'package:leasing_company/features/tasks/domain/models/task_mini_model.dart';

class TaskCursorPaginationModel extends CursorPaginationEntity<TaskMiniModel> {
  TaskCursorPaginationModel(
      {required MetaCursorPaginationModel meta,
      required List<TaskMiniModel> data})
      : super(meta: meta, data: data);

  factory TaskCursorPaginationModel.fromJson(Map<String, dynamic> json) =>
      TaskCursorPaginationModel(
          data: (json['data'] as List<dynamic>)
              .map((e) => TaskMiniModel.fromJson(e))
              .toList(),
          meta: MetaCursorPaginationModel.fromJson(json['meta']));

  CursorPaginationEntity<TaskMiniModel> toEntity() => CursorPaginationEntity(
      meta: (meta as MetaCursorPaginationModel).toEntity(),
      data: List<TaskMiniModel>.from(data));
}

class MetaCursorPaginationModel extends MetaCursorPaginationEntity {
  MetaCursorPaginationModel(
      {required String? nextCursor,
      required String? prevCursor,
      required int perPage})
      : super(nextCursor: nextCursor, prevCursor: prevCursor, perPage: perPage);

  factory MetaCursorPaginationModel.fromJson(Map<String, dynamic> json) =>
      MetaCursorPaginationModel(
          nextCursor: json['next_cursor'],
          prevCursor: json['prev_cursor'],
          perPage: json['per_page']);

  MetaCursorPaginationEntity toEntity() => MetaCursorPaginationEntity(
      nextCursor: nextCursor, prevCursor: prevCursor, perPage: perPage);
}
