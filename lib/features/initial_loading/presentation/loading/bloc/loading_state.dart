import 'package:equatable/equatable.dart';
import 'package:leasing_company/services/file_export_service.dart';
import 'package:leasing_company/services/platform_service.dart';

abstract class LoadingState extends Equatable {
  const LoadingState();

  @override
  List<Object> get props => [];
}

class LoadingInProgressState extends LoadingState {}

class LoadingVersionFailureState extends LoadingState {
  final PlatformInfo platformInfo;

  LoadingVersionFailureState({required this.platformInfo});
}

class LoadingFailureState extends LoadingState {
  final PlatformInfo platformInfo;
  final bool hasFilesForExport;
  final String description;
  final String? errorMessage;

  LoadingFailureState({
    required this.platformInfo,
    required this.hasFilesForExport,
    required this.description,
    this.errorMessage,
  });
}

class LoadingRefreshState extends LoadingState {}

class LoadingOfflineState extends LoadingState {}

class LoadingUnauthenticatedState extends LoadingState {}

class LoadingAuthenticatedState extends LoadingState {}

class LoadingReloadingTasksState extends LoadingState {
  final int progress;
  final int count;
  final bool finish;

  LoadingReloadingTasksState(
      {required this.progress, required this.count, this.finish = false});

  List<Object> get props => [progress, count, finish];
}

class LoadingExportFilesFromStorageState extends LoadingState {
  final Stream<ExportProgress> exportProgress;

  LoadingExportFilesFromStorageState(this.exportProgress);
}
