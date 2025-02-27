import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leasing_company/core/presentation/widgets/missing_and_can_create.dart';
import 'package:leasing_company/features/tasks/domain/enums/task_accessed_by.dart';
import 'package:leasing_company/features/tasks/domain/enums/task_status.dart';
import 'package:leasing_company/features/tasks/domain/models/task_mini_model.dart';
import 'package:leasing_company/features/tasks/presentation/task_create_edit/page/create_edit_task_page.dart';
import 'package:leasing_company/features/tasks/presentation/tasks_list/bloc/tasks.dart';
import 'package:leasing_company/features/tasks/presentation/tasks_list/widgets/task_status_item.dart';
import 'package:leasing_company/features/tasks/presentation/tasks_list/widgets/tasks_row.dart';
import 'package:leasing_company/generated/l10n.dart';

class TasksListPage extends StatefulWidget {
  const TasksListPage({Key? key}) : super(key: key);

  @override
  State<TasksListPage> createState() => _TasksListPageState();
}

class _TasksListPageState extends State<TasksListPage>
    with TickerProviderStateMixin {
  late final bloc;
  late Completer<void> _refreshCompleter;
  late TabController _tabController;
  ScrollController userTasksScrollController = ScrollController();
  ScrollController subdivisionsTasksScrollController = ScrollController();

  TaskStatus? selectedTaskStatus;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    _refreshCompleter = Completer<void>();
    userTasksScrollController.addListener(scrollListener(TaskAccessedBy.user));
    subdivisionsTasksScrollController
        .addListener(scrollListener(TaskAccessedBy.subdivision));
    super.initState();
  }

  scrollListener(TaskAccessedBy accessedBy) {
    ScrollController controller = accessedBy == TaskAccessedBy.user
        ? userTasksScrollController
        : subdivisionsTasksScrollController;
    return () {
      if (controller.position.extentAfter < 150 &&
          _refreshCompleter.isCompleted) {
        _refreshCompleter = Completer<void>();
        bloc.add(TasksLoadMoreEvent(_refreshCompleter, accessedBy));
      }
    };
  }

  @override
  void dispose() {
    userTasksScrollController
        .removeListener(scrollListener(TaskAccessedBy.user));
    subdivisionsTasksScrollController
        .removeListener(scrollListener(TaskAccessedBy.subdivision));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TasksBloc>(
        create: (context) {
          bloc = TasksBloc();
          _refreshCompleter = Completer<void>();
          bloc.add(TasksLoadEvent(_refreshCompleter));
          return bloc;
        },
        child: Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.white,
              title: Text(
                S.of(context).tasksScreenAppBarTitle,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
              ),
              leading: SvgPicture.asset(
                'assets/icons/tasks.svg',
                height: 30,
                width: 30,
                fit: BoxFit.scaleDown,
                color: Colors.black,
              ),
              bottom: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    child: Text(
                      S.of(context).tasksScreenTabMyTasksTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Tab(
                    child: Text(
                      S.of(context).tasksScreenTabAvailableTitle,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            body: BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return TabBarView(
                  controller: _tabController,
                  children: [
                    tabColumnWidget(
                        state is TasksLoadSuccessState ? state.userTasks : [],
                        scrollController: userTasksScrollController,
                        loading: state is TasksLoadInProgress,
                        failed: state is TasksLoadFail),
                    tabColumnWidget(
                        state is TasksLoadSuccessState
                            ? state.subdivisionsTasks
                            : [],
                        scrollController: subdivisionsTasksScrollController,
                        loading: state is TasksLoadInProgress,
                        failed: state is TasksLoadFail),
                  ],
                );
              },
            )));
  }

  Widget tabColumnWidget(List<TaskMiniModel> tasks,
      {required ScrollController scrollController,
      required bool loading,
      required bool failed}) {
    return RefreshIndicator(
      onRefresh: () {
        _refreshCompleter = Completer<void>();
        bloc.add(TasksRefreshEvent(_refreshCompleter));
        return _refreshCompleter.future;
      },
      child: Column(
        children: [
          fastFiltersWidget(),
          if (loading)
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: CircularProgressIndicator(),
            )
          else
            Expanded(
              child: ListView(
                controller: scrollController,
                physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                padding: EdgeInsets.fromLTRB(16, 12, 16, 40),
                children: [
                  if (failed)
                    Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Center(
                            child: Text(S.of(context).tasksScreenErrorTitle)))
                  else if (tasks.isNotEmpty)
                    ...tasks.map((task) => TasksRow(task)).toList()
                  else
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 8),
                      child: MissingAndCanCreateWidget(
                        missingItemsName: S.of(context).tasks,
                        description: S.of(context).waitForTheirAppointmentOr,
                        onCreateButtonTap: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CreateEditTaskPage(),
                            ),
                          );
                          _refreshCompleter = Completer();
                          bloc.add(TasksLoadEvent(_refreshCompleter));
                        },
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget fastFiltersWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 50,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: ListView(
            clipBehavior: Clip.none,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            scrollDirection: Axis.horizontal,
            children: TaskStatus.values
                .map(
                  (taskStatus) => taskStatus != TaskStatus.rejected
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: TaskStatusItem(
                            taskStatus: taskStatus,
                            isSelected: selectedTaskStatus == taskStatus,
                            onTap: (isSelected) {
                              setState(() => selectedTaskStatus =
                                  isSelected ? taskStatus : null);
                              _refreshCompleter = Completer<void>();
                              bloc.add(TasksChangeFilterEvent(
                                      _refreshCompleter, selectedTaskStatus));
                            },
                          ),
                        )
                      : SizedBox(),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
