import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/core/managers/dialogs_manager.dart';
import 'package:leasing_company/core/presentation/widgets/black_bold_text.dart';
import 'package:leasing_company/core/presentation/widgets/custom_outlined_button.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/bloc/make_report_bloc.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/location_undefined.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/review_error.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/review_wait_location.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_type.dart';
import 'package:leasing_company/features/tasks/domain/models/task_model.dart';
import 'package:leasing_company/features/tasks/presentation/task_execution/bloc/task_execution.dart';
import 'package:leasing_company/features/tasks/presentation/task_execution/widgets/media/form_with_title.dart';
import 'package:leasing_company/features/tasks/presentation/task_execution/widgets/media/info.dart';
import 'package:leasing_company/features/tasks/presentation/task_execution/widgets/multimedia_widget.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';

class TaskExecutionPage extends StatefulWidget {
  final TaskModel task;

  TaskExecutionPage({required this.task});

  @override
  State<StatefulWidget> createState() => TaskExecutionPageState();
}

class TaskExecutionPageState extends State<TaskExecutionPage> with WidgetsBindingObserver {
  final DialogManager _dialogManager = getIt();

  BuildContext? makeReportContext;
  bool isNeedToShowValidateResults = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // if (state == AppLifecycleState.paused) {
    //   bloc?.add(MakeReportPauseEvent());
    // }
    // if (state == AppLifecycleState.resumed) {
    //   bloc?.add(MakeReportResumeEvent());
    // }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TaskExecutionBloc(task: widget.task),
        child: BlocBuilder<TaskExecutionBloc, TaskExecutionState>(
          builder: (BuildContext context, TaskExecutionState state) {
            if (state is TaskExecutionInitial) return Center(child: CircularProgressIndicator());

            if (state is TaskExecutionReadyState) {
              return BlocProvider(
                create: (context) {
                  final bloc = MakeReportBloc(
                    taskRemoteId: state.task.remoteId,
                    company: state.company,
                    review: state.review,
                    articleLocalId: null,
                    articleRemoteId: widget.task.article.remoteId,
                    originalTemplate: state.template,
                    context: context,
                  );
                  bloc.add(MakeReportInitEvent(context, false));
                  return bloc;
                },
                child: BlocConsumer<MakeReportBloc, MakeReportState>(
                  listener: (context, state) {
                    if (makeReportContext == null) makeReportContext = context;
                  },
                  builder: (BuildContext context, MakeReportState state) {
                    if (state is MakeReportNotEnoughDiskSpaceState) {
                      return ReviewErrorWidget(S.of(context).makeReportPageNotEnoughDishSpace);
                    }

                    if (state is MakeReportInitState || state is MakeReportFinishState || state is MakeReportInterruptState) {
                      // грузим отчет, ищем местоположение
                      return Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (state is MakeReportWaitLocationState) {
                      return ReviewWaitLocationWidget(
                        changeAccuracyMode: state.changeAccuracyMode,
                        onLocationUndefined: () => context.read<MakeReportBloc>().add(MakeReportLocationUndefinedEvent()),
                      );
                    }
                    if (state is MakeReportLocationUndefinedState) {
                      return LocationUndefinedWidget(
                        onRetry: () =>
                            context.read<MakeReportBloc>()
                                .add(MakeReportRetryLocatingEvent()),
                        onContinueWithoutGps: () =>
                            context.read<MakeReportBloc>()
                                .add(MakeReportWithoutInitialLocationEvent()),
                      );
                    }
                    if (state is MakeReportError) {
                      final description;
                      switch (state.errorType) {
                        case LocationPermissionEnum.LOCATION_SERVICE_DISABLED:
                          description = state.locationService.getServiceDisabledText(context);
                          break;
                        case LocationPermissionEnum.HAVE_NOT_LOCATION_PERMISSION:
                          description = S.of(context).noAccessToGetLocation;
                          break;
                        case LocationPermissionEnum.HAVE_NOT_LOCATION_HIGH_ACCURACY_PERMISSION:
                          description = S.of(context).noAccessToGetExactLocation;
                          break;
                        default:
                          description = '';
                      }
                      return ReviewErrorWidget(description, showSettingButton: state.errorType != LocationPermissionEnum.LOCATION_SERVICE_DISABLED);
                    }

                    if (state is MakeReportReadyState) {
                      return GestureDetector(
                          onTap: () => FocusScope.of(context).unfocus(),
                          child: Scaffold(
                            appBar: AppBar(
                              centerTitle: true,
                              title: Text(
                                state.template.name,
                                maxLines: 2,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            body: ListView(
                              physics: BouncingScrollPhysics(),
                              children: [
                                if (widget.task.description != null) ...[
                                  Container(
                                    padding: EdgeInsets.only(left: 16, right: 16),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                                      SizedBox(height: 14),
                                      BlackBoldText(
                                        S.of(context).taskExecutionDescriptionTitle,
                                        withRedStar: false,
                                        fontSize: 18,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 8,
                                          bottom: 12,
                                        ),
                                        child: Text(
                                          widget.task.description!,
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                      Divider(
                                        color: Color(0xFF89B5FC).withOpacity(0.7),
                                        height: 4,
                                        thickness: 1.0,
                                      ),
                                    ]),
                                  ),
                                ] else
                                  SizedBox(height: 4),
                                ...state.steps.map((step) => stepWidget(step, state.files, state)).toList(),
                                Container(
                                    padding: EdgeInsets.all(20),
                                    child: CustomOutlinedButton(
                                        backgroundColor: Color(0xFF246BFD),
                                        text: S.of(context).taskExecutionFinishButtonTitle,
                                        onPressed: () {
                                          if (state.canFinish == true) {
                                            makeReportContext!.read<MakeReportBloc>().add(MakeReportFinishEvent(false));
                                            Navigator.pop(context, 'pop');
                                          } else {
                                            isNeedToShowValidateResults = true;
                                            makeReportContext!.read<MakeReportBloc>().add(MakeReportRefreshEvent());
                                            _dialogManager.showAlertDialog(context, S.of(context).taskExecutionNotAllConditionsCompleted);
                                          }
                                        })),
                                SizedBox(height: 20),
                              ],
                            ),
                          ));
                    }
                    return Text(state.toString());
                  },
                ),
              );
            }

            return Text("Undefined state");
          },
        ));
  }

  Widget stepWidget(ReviewTemplateStepModel step, List<ReviewStepFile> files, MakeReportReadyState state) {
    var stepFiles = files.where((f) => f.stepId == step.localId).toList().reversed.toList();

    if (step.type == ReviewTemplateStepType.info) {
      return infoStepWidget(step);
    }

    if (step.type == ReviewTemplateStepType.multimedia && step.multimedia != null) {
      return MultimediaWidget(
        multimedia: step.multimedia!,
        step: step,
        stepFiles: stepFiles,
        cacheStorageDir: state.cacheStorageDir,
      );
    }

    if (step.type == ReviewTemplateStepType.form) {
      return formStepWidget(step, stepFiles);
    }

    return Text("${step.title} - undefined type");
  }

  Widget infoStepWidget(ReviewTemplateStepModel step) {
    return InfoWidget(step: step);
  }

  Widget formStepWidget(ReviewTemplateStepModel step, List<ReviewStepFile> stepFiles) {
    ReviewStepFile? file;
    if (stepFiles.length > 0) {
      file = stepFiles[0];
    }
    return FormWithTitle(
        step: step,
        file: file,
        isNeedToShowValidateResults: isNeedToShowValidateResults,
        onChange: (Map<String, dynamic> rawForm) {
          makeReportContext!.read<MakeReportBloc>().add(SingleFormChangedEvent(stepLocalId: step.localId!, rawForm: rawForm));
          makeReportContext!.read<MakeReportBloc>().add(MakeReportRefreshEvent());
        });
  }
}
