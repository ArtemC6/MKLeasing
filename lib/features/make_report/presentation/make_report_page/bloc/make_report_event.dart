part of 'make_report_bloc.dart';

abstract class MakeReportEvent extends Equatable {
  const MakeReportEvent();

  @override
  List<Object> get props => [];
}

class MakeReportInitEvent extends MakeReportEvent {
  final BuildContext context;
  final bool isReview;
  MakeReportInitEvent(this.context, this.isReview);
}

class MakeReportPreviewEvent extends MakeReportEvent {
  final BuildContext context;

  MakeReportPreviewEvent(this.context);
}

class MakeReportRefreshEvent extends MakeReportEvent {}

class MakeReportResumeEvent extends MakeReportEvent {}

class MakeReportPauseEvent extends MakeReportEvent {}

class MakeReportLeaveEvent extends MakeReportEvent {}

class MakeReportInterruptEvent extends MakeReportEvent {}

class MakeReportFinishEvent extends MakeReportEvent {
  final bool isReview;
  MakeReportFinishEvent(this.isReview);
}

class MakeReportLocationUndefinedEvent extends MakeReportEvent {}

class MakeReportRetryLocatingEvent extends MakeReportEvent {}

class MakeReportLocationDetectedEvent extends MakeReportEvent {
  final LocationData newLocation;

  MakeReportLocationDetectedEvent(this.newLocation);
}

class MakeReportWithoutInitialLocationEvent extends MakeReportEvent {}

class MakeReportAddingMediaFileEvent extends MakeReportEvent {
  final List<ReviewStepFileDTO> stepFiles;

  MakeReportAddingMediaFileEvent(this.stepFiles);
}

class MakeReportTakeMediaEvent extends MakeReportEvent {
  final BuildContext context;
  final int stepId;

  MakeReportTakeMediaEvent({required this.context, required this.stepId});
}

class MakeReportChangeMediaCommentEvent extends MakeReportEvent {
  final String fileUuid;
  final String comment;

  MakeReportChangeMediaCommentEvent(
      {required this.fileUuid, required this.comment});
}

class CreateNewStepsEvent extends MakeReportEvent {
  final List<ReviewTemplateStepDTO> listNewSteps;
  final int stepIndex;

  CreateNewStepsEvent(this.listNewSteps, this.stepIndex);
}

class UpdateStepEvent extends MakeReportEvent {
  final ReviewTemplateStepModel updatedStep;

  UpdateStepEvent(this.updatedStep);
}

class CopySectionEvent extends MakeReportEvent {
  final ReviewSection section;

  CopySectionEvent(this.section);
}

class MakeReportChangeStepEvent extends MakeReportEvent {
  final int stepIndex;

  MakeReportChangeStepEvent({required this.stepIndex});
}

class MakeReportNextStepEvent extends MakeReportEvent {
  final BuildContext context;

  MakeReportNextStepEvent({required this.context});
}

class SingleFormChangedEvent extends MakeReportEvent {
  final int stepLocalId;
  final Map<String, dynamic> rawForm;

  SingleFormChangedEvent({required this.stepLocalId, required this.rawForm});
}

class MakeReportDeleteFileEvent extends MakeReportEvent {
  final ReviewStepFile file;

  MakeReportDeleteFileEvent(this.file);
}

class BackToStepsListPageEvent extends MakeReportEvent {}

class AddStepCheckBoxValueChangedEvent extends MakeReportEvent {
  final bool value;

  AddStepCheckBoxValueChangedEvent(this.value);
}

class EndButtonPressedEvent extends MakeReportEvent {
  final BuildContext context;

  EndButtonPressedEvent(this.context);
}

class OnDatabaseInsertError extends MakeReportEvent {
  final String uuid;
  final Completer? completer;

  OnDatabaseInsertError({this.completer, required this.uuid});
}

class GetToWorkOnPressesEvent extends MakeReportEvent {
  final String reviewOrTaskTitle;
  final String objectTitle;

  GetToWorkOnPressesEvent(
      {required this.reviewOrTaskTitle, required this.objectTitle});
}
