import 'package:leasing_company/features/tasks/domain/help_models/create_task_model.dart';
import 'package:leasing_company/features/tasks/domain/repositories/task_repository.dart';

class CreateTaskUseCase {
  final TaskRepository taskRepository;

  CreateTaskUseCase(this.taskRepository);

  Future<bool> call(CreateTaskModel newTask, String companyUuid) =>
      taskRepository.createTask(newTask, companyUuid);
}

