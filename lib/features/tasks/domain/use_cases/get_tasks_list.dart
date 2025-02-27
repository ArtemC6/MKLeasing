import 'package:equatable/equatable.dart';
import 'package:leasing_company/features/company/domain/use_cases/use_case.dart';
import 'package:leasing_company/features/tasks/domain/enums/task_accessed_by.dart';
import 'package:leasing_company/features/tasks/domain/enums/task_status.dart';
import 'package:leasing_company/features/tasks/domain/models/task_mini_model.dart';
import 'package:leasing_company/features/tasks/domain/repositories/task_repository.dart';

class GetTasksListUseCase
    extends UseCase<List<TaskMiniModel>, GetTasksListParams> {
  final TaskRepository taskRepository;

  GetTasksListUseCase(this.taskRepository);

  Future<List<TaskMiniModel>> call(GetTasksListParams params) async {
    return await taskRepository.getList(
        companyUuid: params.companyUuid,
        accessedBy: params.accessedBy,
        status: params.status,
        search: params.search,
        cursor: params.cursor,
        limit: params.limit);
  }
}

class GetTasksListParams extends Equatable {
  final String companyUuid;
  final TaskAccessedBy accessedBy;
  final TaskStatus? status;
  final String? cursor;
  final int limit;
  final String? search;

  GetTasksListParams({
    required this.companyUuid,
    required this.accessedBy,
    required this.cursor,
    required this.limit,
    this.search,
    this.status,
  });

  @override
  List<Object?> get props =>
      [companyUuid, accessedBy, status, cursor, limit, search];
}
