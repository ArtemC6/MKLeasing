import 'package:equatable/equatable.dart';
import 'package:leasing_company/features/company/domain/use_cases/use_case.dart';
import 'package:leasing_company/features/tasks/domain/enums/task_status.dart';
import 'package:leasing_company/features/tasks/domain/repositories/task_repository.dart';

class ChangeStatusUseCase extends UseCase<bool, ChangeStatusParams> {
  final TaskRepository taskRepository;

  ChangeStatusUseCase(this.taskRepository);

  Future<bool> call(ChangeStatusParams params) async {
    return await taskRepository.changeStatus(
        companyUuid: params.companyUuid, id: params.id, status: params.status);
  }
}

class ChangeStatusParams extends Equatable {
  final String companyUuid;
  final int id;
  final TaskStatus status;

  ChangeStatusParams(
      {required this.companyUuid, required this.id, required this.status});

  @override
  List<Object?> get props => [companyUuid, id];
}
