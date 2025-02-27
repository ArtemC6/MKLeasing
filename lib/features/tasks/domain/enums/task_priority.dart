import 'package:flutter/material.dart';
import 'package:leasing_company/generated/l10n.dart';

enum TaskPriority { low, medium, high }

extension TaskPriorityExtension on TaskPriority {
  String get value {
    switch (this) {
      case TaskPriority.low:
        return 'low';
      case TaskPriority.medium:
        return 'medium';
      case TaskPriority.high:
        return 'high';
    }
  }

  String getWithLocalization(BuildContext context){
    switch(this){
      case TaskPriority.low: return S.of(context).low;
      case TaskPriority.medium: return S.of(context).medium;
      case TaskPriority.high: return S.of(context).high;
    }
  }

  static TaskPriority parse(String str, BuildContext context){
    if(str == S.of(context).low){
      return TaskPriority.low;
    } else if(str == S.of(context).medium){
      return TaskPriority.medium;
    } else {
      return TaskPriority.high;
    }
  }
}
