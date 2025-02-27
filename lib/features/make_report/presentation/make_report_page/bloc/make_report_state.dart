part of 'make_report_bloc.dart';

abstract class MakeReportState extends Equatable {
  const MakeReportState();

  @override
  List<Object> get props => [];
}

class MakeReportInitState extends MakeReportState {}

class MakeReportNotEnoughDiskSpaceState extends MakeReportState {
  final double freeDiskSpace;

  MakeReportNotEnoughDiskSpaceState({required this.freeDiskSpace});
}

class MakeReportSignState extends MakeReportState {
  final String? pdfFile;

  MakeReportSignState(this.pdfFile);
}

enum MakeReportErrorEnum { PERMISSION, OTHER }

class MakeReportError extends MakeReportState {
  final LocationPermissionEnum errorType;
  final LocationService locationService;

  MakeReportError(this.errorType, this.locationService);
}

class MakeReportWaitLocationState extends MakeReportState {
  final Function(CustomLocationAccuracy) changeAccuracyMode;

  MakeReportWaitLocationState(this.changeAccuracyMode);
}

class MakeReportLocationUndefinedState extends MakeReportState {}

class MakeReportReadyState extends MakeReportState {
  final Review review; // TODO: must be deleted!
  final ReviewTemplateModel template;
  final List<StepModel> steps;
  final List<ReviewTemplateStepFormModel> forms;
  final List<ReviewStepFile> files;
  final List<ReviewStepViolation> violations;
  final bool canFinish;

  final int currentStepIndex;

  final String storageDir;
  final String cacheStorageDir;
  final String compressedStorageDir;
  final bool isNeedDisplayStepsList;
  final bool isAddStepCheckBoxSelected;
  final List<ReviewSection>? sections;

  MakeReportReadyState({
    required this.review, // TODO: must be deleted!
    required this.template,
    required this.steps,
    required this.forms,
    required this.files,
    required this.violations,
    required this.currentStepIndex,
    required this.storageDir,
    required this.cacheStorageDir,
    required this.compressedStorageDir,
    required this.canFinish,
    required this.isNeedDisplayStepsList,
    required this.isAddStepCheckBoxSelected,
    required this.sections,
  });

  // @override
  // List<Object> get props => [Uuid().v4()];

  @override
  List<Object> get props => [
        Uuid().v4(),
        currentStepIndex,
        ...steps.map((e) => e.localId ?? 0).toList(),
        ...forms.map((e) => e.localId ?? 0).toList(),
        ...files.map((e) => e.uuid).toList(),
        ...violations.map((e) => e.stepId).toList(),
        canFinish,
      ];
}

class MakeReportLeaveState extends MakeReportState {}

class MakeReportInterruptState extends MakeReportState {}

class MakeReportFinishState extends MakeReportState {
  final bool repeatable;

  MakeReportFinishState({required this.repeatable});
}

class MakeReportDatabaseRefreshState extends MakeReportState {
  final List<ReviewModel> reviews;
  final CompanyEntity companyEntity;

  MakeReportDatabaseRefreshState({
    required this.reviews,
    required this.companyEntity,
  });
}

class MakeReportPreviewState extends MakeReportState {
  final ReviewTemplateModel template;
  final List<StepModel> steps;

  final int currentStepIndex;

  final List<ReviewSection>? sections;

  MakeReportPreviewState({
    required this.template,
    required this.steps,
    required this.currentStepIndex,
    required this.sections,
  });
}

class GotToWorkState extends MakeReportState {
  final bool available;
  GotToWorkState({required this.available});
}
