import 'package:leasing_company/features/tasks/domain/models/task_cursor_pagination_model.dart';
import 'package:leasing_company/features/tasks/domain/enums/task_accessed_by.dart';
import 'package:leasing_company/features/tasks/domain/enums/task_status.dart';
import 'package:leasing_company/features/tasks/domain/help_models/create_task_model.dart';
import 'package:leasing_company/features/tasks/domain/help_models/update_task_model.dart';
import 'package:leasing_company/features/tasks/domain/models/task_mini_model.dart';
import 'package:leasing_company/features/tasks/domain/models/task_model.dart';

abstract class TaskRemoteDatasource {
  Future<List<TaskMiniModel>> getList({
    required String companyUuid,
    required TaskAccessedBy accessedBy,
    required TaskStatus? status,
    required String? cursor,
    required int limit,
    String? search,
  });

  Future<TaskModel> getById({required String companyUuid, required int id});

  Future<bool> changeStatus({
    required String companyUuid,
    required int id,
    required TaskStatus status,
  });

  Future<TaskCursorPaginationModel> getPaginationList({
    required String companyUuid,
    required TaskAccessedBy accessedBy,
    required TaskStatus? status,
    required String? cursor,
    required int limit,
  });

  Future<bool> createTask(CreateTaskModel newTask, String companyUuid);

  Future<bool> updateTask(UpdateTaskModel updateTaskModel, String companyUuid);
}
