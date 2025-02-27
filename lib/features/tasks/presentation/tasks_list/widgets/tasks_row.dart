import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/features/tasks/domain/enums/task_status.dart';
import 'package:leasing_company/features/tasks/domain/models/task_mini_model.dart';
import 'package:leasing_company/features/tasks/presentation/task_detail/pages/task_detail.dart';
import 'package:leasing_company/features/tasks/presentation/tasks_list/bloc/tasks.dart';
import 'package:leasing_company/generated/l10n.dart';

class TasksRow extends StatefulWidget {
  final TaskMiniModel task;

  TasksRow(this.task);

  @override
  State<TasksRow> createState() => _TasksRowState();
}

class _TasksRowState extends State<TasksRow> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: isExpanded ? 220 : 110,
      ),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1,
          color: Color(0xffE1E1E1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.08),
            offset: const Offset(0, 4),
            blurRadius: 6,
          ),
          BoxShadow(color: Colors.white), //BoxShadow
        ],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 16, 8, 8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_buildShortCard()],
          ),
        ),
      ),
    );
  }

  Widget _buildShortCard() {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => TaskDetailScreen(
                    taskId: widget.task.id,
                  )),
        );

        BlocProvider.of<TasksBloc>(context)
            .add(TasksLoadEvent(Completer<void>()));
      },
      child: Container(
        constraints: BoxConstraints(minHeight: 94),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 28),
              width: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(7),
                  bottomRight: Radius.circular(7),
                ),
                color: widget.task.status.statusColor,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        widget.task.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    if (widget.task.subdivisions.length > 0)
                      Padding(
                        padding: const EdgeInsets.only(left: 30, top: 6),
                        child: Text(
                          widget.task.subdivisions.join(', '),
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    if (widget.task.startExecutionAt != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2, left: 30),
                        child: Text(
                          S.of(context).tasksRowStartExecutionAt(
                              DateTime.fromMillisecondsSinceEpoch(
                                  widget.task.startExecutionAt! * 1000)),
                          softWrap: true,
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    if (widget.task.finishExecutionAt != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2, left: 30),
                        child: Text(
                          S.of(context).tasksRowFinishExecutionAt(
                              DateTime.fromMillisecondsSinceEpoch(
                                  widget.task.finishExecutionAt! * 1000)),
                          softWrap: true,
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, left: 30),
                      child: Text(
                        widget.task.status.statusTitle(context),
                        softWrap: true,
                        style: TextStyle(
                          color: widget.task.status.statusColor,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Icon(
              isExpanded
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_right,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
