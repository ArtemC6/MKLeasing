import 'dart:async';

import 'package:equatable/equatable.dart';

abstract class LoadingEvent extends Equatable {
  const LoadingEvent();

  @override
  List<Object> get props => [];
}

class LoadingAppStartEvent extends LoadingEvent {}

class LoadingRefreshEvent extends LoadingEvent {
  final Completer refreshCompleter;

  LoadingRefreshEvent(this.refreshCompleter);
}

class LoadingAuthenticationEvent extends LoadingEvent {}

class LoadingExportFilesFromStorageEvent extends LoadingEvent {}
