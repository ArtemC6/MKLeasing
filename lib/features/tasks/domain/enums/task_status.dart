import 'package:flutter/material.dart';
import 'package:leasing_company/generated/l10n.dart';

enum TaskStatus {
  assigned,
  at_work,
  rejected,
  on_inspection,
  completed,
}

extension TaskStatusExtension on TaskStatus {
  String get value {
    switch (this) {
      case TaskStatus.assigned:
        return 'assigned';
      case TaskStatus.at_work:
        return 'at_work';
      case TaskStatus.rejected:
        return 'rejected';
      case TaskStatus.on_inspection:
        return 'on_inspection';
      case TaskStatus.completed:
        return 'completed';
    }
  }

  String statusTitle(BuildContext context){
    switch(this){
    case TaskStatus.assigned: return S.of(context).tasksScreenFastFilterAssignedStatusTitle;
    case TaskStatus.at_work: return  S.of(context).tasksScreenFastFilterAtWorkStatusTitle;
    case TaskStatus.rejected: return S.of(context).tasksScreenFastFilterRejectedStatusTitle;
    case TaskStatus.on_inspection: return S.of(context).tasksScreenFastFilterOnInspectionStatusTitle;
    case TaskStatus.completed: return S.of(context).tasksScreenFastFilterCompletedStatusTitle;
    }
  }

  Color get statusColor {
    switch (this) {
      case TaskStatus.assigned:
        return Color.fromARGB(255, 103, 58, 179);
      case TaskStatus.at_work:
        return Color(0xff009689);
      case TaskStatus.rejected:
        return Color.fromARGB(255, 255, 87, 38);
      case TaskStatus.on_inspection:
        return Color.fromARGB(255, 255, 192, 45);
      case TaskStatus.completed:
        return Color.fromARGB(255, 139, 194, 85);
    }
  }
}