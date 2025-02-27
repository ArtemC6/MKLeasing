import 'package:equatable/equatable.dart';
import 'package:leasing_company/features/tasks/domain/enums/task_accessed_by.dart';
import 'package:leasing_company/features/tasks/domain/enums/task_status.dart';
import 'package:leasing_company/features/tasks/domain/models/task_mini_model.dart';
import 'package:leasing_company/features/tasks/domain/repositories/task_repository.dart';
import 'package:leasing_company/main.dart';

class GetMoreTasksUseCase {
  final TaskRepository taskRepository = getIt<TaskRepository>();

  final GetMoreTasksParams params;
  bool _first = true;
  String? _nextCursor;

  GetMoreTasksUseCase(this.params);

  @override
  Future<List<TaskMiniModel>?> call() async {
    if (_first == true || _nextCursor != null) {
      _first = false;
      var tasksPagination = await taskRepository.getPaginationList(
          companyUuid: params.companyUuid,
          accessedBy: params.accessedBy,
          status: params.status,
          cursor: _nextCursor,
          limit: 25);
      _nextCursor = tasksPagination.meta.nextCursor;
      return tasksPagination.data;
    }
    return null;
  }

  bool hasNext() => _first == true || _nextCursor != null;
}

class GetMoreTasksParams extends Equatable {
  final String companyUuid;
  final TaskAccessedBy accessedBy;
  final TaskStatus? status;

  GetMoreTasksParams(
      {required this.companyUuid,
      required this.accessedBy,
      required this.status});

  @override
  List<Object?> get props => [companyUuid, accessedBy, status];
}
