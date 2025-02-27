import 'package:flutter/material.dart';
import 'package:leasing_company/generated/l10n.dart';

enum ReviewStatus {
  scheduled,
  inWork,
  isRework
}

extension ReviewStatusInfo on ReviewStatus {
  String name(BuildContext context) {
    switch(this){
      case ReviewStatus.scheduled:
        return S.of(context).tasksScreenFastFilterAssignedStatusTitle;
      case ReviewStatus.inWork:
        return S.of(context).tasksScreenFastFilterAtWorkStatusTitle;
      case ReviewStatus.isRework:
        return S.of(context).isNeedRework;
    }
  }

  Color statusColor() {
    switch(this){
      case ReviewStatus.scheduled:
        return Color(0xFF673AB3);
      case ReviewStatus.inWork:
        return Color(0xFF009689);
      case ReviewStatus.isRework:
      return Color(0xFFFF981F);
    }
  }
}
