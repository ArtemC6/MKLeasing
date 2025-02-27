import 'package:leasing_company/features/tasks/domain/enums/task_priority.dart';

class UpdateTaskModel{
  final int taskId;
  final String address;
  final bool isNeedSendToApproval;
  final DateTime? startExecutionAt;
  final DateTime? finishExecutionAt;
  final TaskPriority? priority;

  UpdateTaskModel({
    this.address = '',
    this.isNeedSendToApproval = true,
    this.startExecutionAt,
    this.finishExecutionAt,
    this.priority,
    required this.taskId,
  });

  Map toJson() {
    return {
      "address": address,
      "start_execution_at": startExecutionAt != null
          ? startExecutionAt!.millisecondsSinceEpoch ~/ 1000
          : null,
      "finish_execution_at": finishExecutionAt != null
          ? finishExecutionAt!.millisecondsSinceEpoch ~/ 1000
          : null,
      "send_for_verification": isNeedSendToApproval,
      "priority": priority?.value
    };
  }
}