import 'package:flutter/material.dart';

enum StepStatus {
  awaitingExecution,
  valid,
  notValid,
}

extension StepStatusInfo on StepStatus {
  Color getMainColor() {
    switch (this) {
      case StepStatus.awaitingExecution:
        return Color(0xFFA7C4FE);
      case StepStatus.valid:
        return Color(0xFF0BB783);
      case StepStatus.notValid:
        return Color(0xFFF64E60);
    }
  }

  Color? getBackgroundColor() {
    switch (this) {
      case StepStatus.awaitingExecution:
        return null;
      case StepStatus.valid:
        return Color(0xFF0BB783).withOpacity(0.07);
      case StepStatus.notValid:
        return Color(0xFFF64E60).withOpacity(0.07);
    }
  }
}
