
import 'package:leasing_company/features/tasks/domain/help_models/update_task_model.dart';
import 'package:leasing_company/features/tasks/domain/repositories/task_repository.dart';

class UpdateTaskUseCase{
  final TaskRepository _repository;

  UpdateTaskUseCase(this._repository);

  Future<bool> call(UpdateTaskModel updateTaskModel, String companyUuid){
    return _repository.updateTask(updateTaskModel, companyUuid);
  }
}