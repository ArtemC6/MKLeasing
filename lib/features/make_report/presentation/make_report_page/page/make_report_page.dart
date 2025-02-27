import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/core/managers/dialogs_manager.dart';
import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/bloc/make_report_bloc.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/models/step_status.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/page/sign_review_page.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/buttons_widget.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/list_steps_and_sections/list_steps_and_sections.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/location_undefined.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/review_error.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/review_wait_location.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/step_widget.dart';
import 'package:leasing_company/features/make_report/presentation/review_create_step/page/review_steps_create_page.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_model.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_dto.dart';
import 'package:leasing_company/generated/l10n.dart';
import 'package:leasing_company/main.dart';

class MakeReportPage extends StatefulWidget {
  final CompanyEntity company;
  final Article article;
  final ReviewTemplateModel template;
  final Review? review;
  final bool isOpenedFromReviews;
  final int? index;

  MakeReportPage({
    required this.company,
    required this.article,
    required this.template,
    this.review,
    this.isOpenedFromReviews = false,
    this.index,
  });

  @override
  State<StatefulWidget> createState() => MakeReportPageState();
}

class MakeReportPageState extends State<MakeReportPage> with WidgetsBindingObserver {
  final DialogManager _dialogManager = getIt();
  MakeReportBloc? bloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      bloc?.add(MakeReportPauseEvent());
    }
    if (state == AppLifecycleState.resumed) {
      if (!(bloc?.state is MakeReportSignState)) {
        bloc?.add(MakeReportResumeEvent());
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = MakeReportBloc(
          company: widget.company,
          review: widget.review,
          articleLocalId: widget.article.id,
          articleRemoteId: widget.article.remoteId,
          originalTemplate: widget.template,
          context: context,
        );
        bloc.add(MakeReportInitEvent(context, true));
        return bloc;
      },
      child: BlocConsumer<MakeReportBloc, MakeReportState>(
        listener: (context, state) {
          if (state is MakeReportDatabaseRefreshState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MakeReportPage(
                  company: state.companyEntity,
                  article: state.reviews[widget.index ?? 0].article,
                  template: ReviewTemplateModel.fromDBModel(state.reviews[widget.index ?? 0]),
                  review: state.reviews[widget.index ?? 0].review,
                  isOpenedFromReviews: true,
                  index: widget.index ?? 0,
                ),
              ),
            );
          }

          if (state is MakeReportLeaveState) {
            Navigator.pop(context, 'pop');
          }
          if (state is MakeReportFinishState) {
            if (state.repeatable) {
              wannaRepeat(
                context,
                widget.company,
                widget.article,
                bloc!.originalTemplate,
              );
            } else {
              Navigator.pop(context, 'pop');
            }
          }
          if (state is MakeReportInterruptState) {
            Navigator.pop(context, 'pop');
          }
        },
        builder: (BuildContext context, MakeReportState state) {
          bloc ??= context.read<MakeReportBloc>();
          if (state is MakeReportInitState || state is MakeReportFinishState || state is MakeReportInterruptState) {
            // грузим отчет, ищем местоположение
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is MakeReportDatabaseRefreshState) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is MakeReportNotEnoughDiskSpaceState) {
            return ReviewErrorWidget(S.of(context).makeReportPageNotEnoughDishSpace);
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
          if (state is MakeReportWaitLocationState) {
            return ReviewWaitLocationWidget(
              changeAccuracyMode: state.changeAccuracyMode,
              onLocationUndefined: () => bloc?.add(MakeReportLocationUndefinedEvent()),
            );
          }
          if (state is MakeReportLocationUndefinedState) {
            return LocationUndefinedWidget(
              onRetry: () => bloc?.add(MakeReportRetryLocatingEvent()),
              onContinueWithoutGps: () =>
                  bloc?.add(MakeReportWithoutInitialLocationEvent()),
            );
          }

          if (state is MakeReportSignState) {
            return SignReviewPage(
              pdfFile: state.pdfFile,
            );
          }
          if (state is MakeReportReadyState) {
            if (state.steps.isNotEmpty) {
              final keys = state.steps.map((e) => GlobalKey()).toList();
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                final stepItemContext = keys[state.currentStepIndex >= 2 ? state.currentStepIndex - 2 : 0].currentContext;
                if (stepItemContext != null) {
                  Scrollable.ensureVisible(
                    stepItemContext,
                    duration: Duration(milliseconds: 500),
                  );
                }
              });

              return WillPopScope(
                onWillPop: () async {
                  if (state.isNeedDisplayStepsList) {
                    final isNeedPop = await onWillPop(
                      this.context,
                      context.read<MakeReportBloc>(),
                    );
                    if (isNeedPop) {
                      Navigator.pop(context, 'pop');
                    }
                    return false;
                  } else {
                    context.read<MakeReportBloc>().add(BackToStepsListPageEvent());
                    return Future.value(false);
                  }
                },
                child: Scaffold(
                  appBar: AppBar(
                    elevation: state.isNeedDisplayStepsList ? 1.5 : 0,
                    title: Text(
                      widget.template.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    actions: [
                      if (!widget.template.private)
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Color(0xffF64E60),
                          ),
                          onPressed: () async {
                            final bool? isNeedToDelete = await _dialogManager.showOnDeleteDialog(
                              context,
                              S.of(context).makeReportPageAreYouSureForDelete,
                            );
                            if (isNeedToDelete == true) {
                              context.read<MakeReportBloc>().add(MakeReportInterruptEvent());
                            }
                          },
                        ),
                    ],
                  ),
                  body: state.isNeedDisplayStepsList
                      ? ListStepsAndSectionsWidget(state: state)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 2),
                              decoration: BoxDecoration(
                                color: Color(0xffFDFDFD),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                    offset: Offset(0, 0),
                                  )
                                ],
                              ),
                              height: 46,
                              child: _circleStepsList(context, state, keys),
                            ),
                            Expanded(
                              key: ObjectKey(state.currentStepIndex),
                              child: StepWidget(
                                step: state.steps[state.currentStepIndex],
                                state: state,
                                bloc: bloc!,
                                company: widget.company,
                                files: state.files.where((element) => element.stepId == state.steps[state.currentStepIndex].localId).toList(),
                                cacheStorageDir: state.cacheStorageDir,
                              ),
                            ),
                            ButtonsWidget(),
                          ],
                        ),
                ),
              );
            } else {
              if (widget.isOpenedFromReviews) {
                bloc?.add(OnDatabaseInsertError(uuid: state.review.uuid));
                return Scaffold(body: Center(child: CircularProgressIndicator()));
              }
            }
          }

          return Scaffold(
            body: Center(
              child: Text(S.of(context).makeReportPageUndefinedState + state.toString()),
            ),
          );
        },
      ),
    );
  }

  Widget _circleStepsList(
    BuildContext context,
    MakeReportReadyState state,
    List<GlobalKey> keys,
  ) {
    return ListView.separated(
        padding: EdgeInsets.fromLTRB(8, 2, 16, 6),
        itemCount: state.steps.length,
        physics: BouncingScrollPhysics(),

        /// Needed for automatic scroll list circle steps
        cacheExtent: MediaQuery.of(context).size.width * 50,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (ctx, index) {
          return SizedBox(
            width: 10,
            child: Divider(
              thickness: 2,
              color: Color(0xFFE0E2E5),
            ),
          );
        },
        itemBuilder: (context, index) {
          return GestureDetector(
            key: keys[index],
            onTap: () {
              _onStepTap(context, state, index);
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 250),
              height: 36,
              width: 36,
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: state.currentStepIndex == index ? Colors.blue : state.steps[index].stepStatus.getMainColor(),
              ),
              child: state.steps[index].stepStatus == StepStatus.valid
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 24,
                    )
                  : Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
            ),
          );
        });
  }

  Future<void> _onStepTap(
    BuildContext context,
    MakeReportReadyState state,
    int index,
  ) async {
    if (state.isAddStepCheckBoxSelected) {
      final isNeedCreateStep = await _dialogManager.showApproveDialog(
        context,
        S.of(context).goToCreateAnAdditionalStep,
      );
      if (isNeedCreateStep) {
        final newStep = await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ReviewStepsCreatePage(
            sectionId: state.steps[state.currentStepIndex].sectionId,
            localSectionId: state.steps[state.currentStepIndex].localSectionId,
          ),
        ));
        if (newStep != null && newStep is ReviewTemplateStepDTO) {
          context.read<MakeReportBloc>().add(CreateNewStepsEvent([newStep], state.currentStepIndex));
        }
      }
    }
    BlocProvider.of<MakeReportBloc>(context).add(
      MakeReportChangeStepEvent(stepIndex: index),
    );
  }

  Future<bool> onWillPop(BuildContext context, MakeReportBloc bloc) async {
    return _dialogManager.showOnWillPopDialog(context);
  }

  Future<void> wannaRepeat(BuildContext context, CompanyEntity company, Article article, ReviewTemplateModel template) async {
    final S locales = S();
    final isNeedRepeatReview = await _dialogManager.showBoolDialog(context, locales.makeReportPageAnotherReportWithThisTemplate);
    if (isNeedRepeatReview) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MakeReportPage(
            company: company,
            article: article,
            template: template,
          ),
        ),
      );
    }
    Navigator.pop(context, 'pop');
  }
}
