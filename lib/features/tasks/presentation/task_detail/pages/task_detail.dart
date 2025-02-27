import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:leasing_company/core/presentation/widgets/custom_outlined_button.dart';
import 'package:leasing_company/features/tasks/domain/enums/task_status.dart';
import 'package:leasing_company/features/tasks/presentation/task_create_edit/page/create_edit_task_page.dart';
import 'package:leasing_company/features/tasks/presentation/task_detail/bloc/task_detail.dart';
import 'package:leasing_company/features/tasks/presentation/task_execution/pages/task_execution_page.dart';
import 'package:leasing_company/features/tasks/presentation/tasks_list/bloc/tasks.dart';
import 'package:leasing_company/generated/l10n.dart';

class TaskDetailScreen extends StatefulWidget {
  final int taskId;

  const TaskDetailScreen({
    required this.taskId,
    Key? key,
  }) : super(key: key);

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TaskDetailBloc(taskId: widget.taskId),
      child: BlocBuilder<TaskDetailBloc, TaskDetailState>(
        builder: (BuildContext context, state) {
          if (state is TaskDetailReadyState) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  state.task.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                actions: state.task.editable &&
                        state.task.status == TaskStatus.at_work &&
                        !state.isTaskExecutionStarted
                    ? [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: IconButton(
                            onPressed: () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CreateEditTaskPage(
                                    taskId: state.task.remoteId,
                                  ),
                                ),
                              );
                              context
                                  .read<TaskDetailBloc>()
                                  .add(TaskDetailLoadEvent());
                            },
                            icon: SvgPicture.asset(
                              'assets/icons/edit.svg',
                              width: 26,
                              height: 26,
                            ),
                          ),
                        )
                      ]
                    : null,
              ),
              body: ListView(
                padding: EdgeInsets.fromLTRB(24, 18, 24, 24),
                physics: BouncingScrollPhysics(),
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/objects.svg',
                        color: Color(0xFF246BFD),
                        height: 24,
                        width: 24,
                      ),
                      SizedBox(width: 8),
                      Text(
                        S.of(context).taskInfoScreenArticleTitle + ':',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text(
                    state.task.article.title,
                    style: TextStyle(fontSize: 16),
                  ),
                  ...buildStringInfoElement(
                    title: S.of(context).taskInfoScreenDescriptionTitle,
                    content: state.task.description,
                  ),
                  ...buildDateInfoElement(
                    title: S.of(context).startOfExecution,
                    timestamp: state.task.startExecutionAt,
                  ),
                  ...buildDateInfoElement(
                    title: S.of(context).taskInfoScreenFinishDateLimitTitle,
                    timestamp: state.task.finishExecutionAt,
                  ),
                  ...buildStringInfoElement(
                    title: S.of(context).taskInfoScreenAddressTitle,
                    content: state.task.address,
                  ),
                  ...buildStringInfoElement(
                    title: S.of(context).comment,
                    content: state.task.comment,
                  ),
                  if (state.task.reviewTemplate.steps != null &&
                      state.task.reviewTemplate.steps!.isNotEmpty) ...[
                    SizedBox(height: 24),
                    Text(
                      S.of(context).necessaryActionsForTask + ':',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    ...state.task.reviewTemplate.steps!
                        .map(
                          (step) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  margin: EdgeInsets.only(top: 5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF246BFD)),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    step.title,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList()
                  ],
                  if (state.task.status == TaskStatus.assigned) ...[
                    SizedBox(height: 34),
                    CustomOutlinedButton(
                      text: S.of(context).taskInfoScreenTakeToWorkButtonTitle,
                      backgroundColor: Color(0xFF246BFD),
                      onPressed: () {
                        BlocProvider.of<TaskDetailBloc>(context).add(
                          TaskDetailTakeAtWorkEvent(
                              id: widget.taskId,
                              reviewOrTaskTitle: state.task.title,
                              objectTitle: state.task.article.title),
                        );
                      },
                    ),
                    if (state.task.rejectable == true)
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: CustomOutlinedButton(
                          borderColor: Color(0xff0055FF),
                          backgroundColor: Color(0xFFFDFDFD),
                          foregroundColor: Color(0xff0055FF),
                          text: S.of(context).taskInfoRefuseButtonTitle,
                          onPressed: () {
                            BlocProvider.of<TaskDetailBloc>(context).add(
                              TaskDetailRefuseEvent(
                                  id: widget.taskId,
                                  reviewOrTaskTitle: state.task.title,
                                  objectTitle: state.task.article.title),
                            );
                          },
                        ),
                      )
                  ],
                  if (state.task.status == TaskStatus.at_work &&
                      state.canExecute) ...[
                    SizedBox(height: 34),
                    CustomOutlinedButton(
                      backgroundColor: Color(0xFF246BFD),
                      text: S.of(context).taskInfoScreenExecuteButtonTitle,
                      onPressed: () async {
                        var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TaskExecutionPage(
                              task: state.task,
                            ),
                          ),
                        );
                        context
                            .read<TaskDetailBloc>()
                            .add(TaskDetailLoadEvent());

                        if (result == 'pop') {
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ],
              ),
            );
          }
          if (state is TaskDetailLoadInProgress) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  '-',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                '-',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            body: Center(
              child: Text(S.of(context).taskDetailErrorFailedTitle),
            ),
          );
        },
      ),
    );
  }

  List<Widget> buildStringInfoElement({
    required String title,
    required String? content,
  }) {
    return content != null && content.isNotEmpty
        ? [
            SizedBox(height: 24),
            Text(
              title + ':',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ]
        : [];
  }

  List<Widget> buildDateInfoElement({
    required String title,
    required int? timestamp,
  }) {
    final dateStr = timestamp != null
        ? DateFormat('dd.MM.yyyy')
            .format(DateTime.fromMillisecondsSinceEpoch(timestamp * 1000))
            .toString()
        : null;
    return dateStr != null
        ? [
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 8),
              child: Text(
                title + ':',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/clock.svg',
                ),
                SizedBox(width: 8),
                Text(
                  dateStr,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ]
        : [];
  }
}
