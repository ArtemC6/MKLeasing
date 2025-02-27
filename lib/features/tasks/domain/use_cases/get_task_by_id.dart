import 'package:equatable/equatable.dart';
import 'package:leasing_company/features/company/domain/use_cases/use_case.dart';
import 'package:leasing_company/features/tasks/domain/models/task_model.dart';
import 'package:leasing_company/features/tasks/domain/repositories/task_repository.dart';

class GetTaskByIdUseCase extends UseCase<TaskModel, GetTaskByIdParams> {
  final TaskRepository taskRepository;

  GetTaskByIdUseCase(this.taskRepository);

  Future<TaskModel> call(GetTaskByIdParams params) async {
    return await taskRepository.getRemoteByRemoteId(
        companyUuid: params.companyUuid, id: params.id);
  }
}

class GetTaskByIdParams extends Equatable {
  final String companyUuid;
  final int id;

  GetTaskByIdParams({required this.companyUuid, required this.id});

  @override
  List<Object?> get props => [companyUuid, id];
}
