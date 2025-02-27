import 'package:flutter/material.dart';
import 'package:leasing_company/features/tasks/domain/enums/task_status.dart';

class TaskStatusItem extends StatelessWidget {
  final TaskStatus taskStatus;
  final bool isSelected;
  final Function(bool) onTap;

  const TaskStatusItem({
    Key? key,
    required this.taskStatus,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: (){
          onTap(!isSelected);
        },
        child: Ink(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected ? taskStatus.statusColor : Colors.transparent,
            border: Border.all(color: taskStatus.statusColor,width: 2),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Text(
              taskStatus.statusTitle(context),
              style: TextStyle(
                color: isSelected ? Colors.white : taskStatus.statusColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
