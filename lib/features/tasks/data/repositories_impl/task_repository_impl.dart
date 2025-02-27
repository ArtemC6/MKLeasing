import 'package:leasing_company/features/tasks/domain/entities/cursor_pagination_entity.dart';
import 'package:leasing_company/features/tasks/data/datasources/task_remote_datasource.dart';
import 'package:leasing_company/features/tasks/domain/enums/task_accessed_by.dart';
import 'package:leasing_company/features/tasks/domain/enums/task_status.dart';
import 'package:leasing_company/features/tasks/domain/help_models/create_task_model.dart';
import 'package:leasing_company/features/tasks/domain/help_models/update_task_model.dart';
import 'package:leasing_company/features/tasks/domain/models/task_mini_model.dart';
import 'package:leasing_company/features/tasks/domain/models/task_model.dart';
import 'package:leasing_company/features/tasks/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDatasource taskRemoteDatasource;

  TaskRepositoryImpl(this.taskRemoteDatasource);

  @override
  Future<TaskModel> getRemoteByRemoteId({
    required String companyUuid,
    required int id,
  }) async {
    return await taskRemoteDatasource.getById(companyUuid: companyUuid, id: id);
  }

  @override
  Future<List<TaskMiniModel>> getList({
    required String companyUuid,
    required TaskAccessedBy accessedBy,
    required TaskStatus? status,
    required String? cursor,
    required int limit,
    String? search,
  }) async {
    return await taskRemoteDatasource.getList(
      companyUuid: companyUuid,
      accessedBy: accessedBy,
      status: status,
      cursor: cursor,
      limit: limit,
      search: search,
    );
  }

  @override
  Future<bool> changeStatus({
    required String companyUuid,
    required int id,
    required TaskStatus status,
  }) async {
    return await taskRemoteDatasource.changeStatus(
        companyUuid: companyUuid, id: id, status: status);
  }

  @override
  Future<CursorPaginationEntity<TaskMiniModel>> getPaginationList({
    required String companyUuid,
    required TaskAccessedBy accessedBy,
    required TaskStatus? status,
    required String? cursor,
    required int limit,
  }) async {
    final taskCursorPaginationModel =
        await taskRemoteDatasource.getPaginationList(
      companyUuid: companyUuid,
      accessedBy: accessedBy,
      status: status,
      cursor: cursor,
      limit: limit,
    );

    return taskCursorPaginationModel.toEntity();
  }

  @override
  Future<bool> createTask(CreateTaskModel newTask, String companyUuid) =>
      taskRemoteDatasource.createTask(newTask, companyUuid);

  @override
  Future<bool> updateTask(
    UpdateTaskModel updateTaskModel,
    String companyUuid,
  ) =>
      taskRemoteDatasource.updateTask(updateTaskModel, companyUuid);
}
