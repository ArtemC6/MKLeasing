import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/core/config/repositories/config_repository.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/company/domain/repositories/company_repository.dart';
import 'package:leasing_company/features/help/domain/repositories/help_question_repository.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/file_export_service.dart';
import 'package:leasing_company/services/file_path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'help_event.dart';
import 'help_state.dart';

class HelpBloc extends Bloc<HelpEvent, HelpState> {
  final ConfigRepository configRepository = getIt();
  final FileExportService fileExportService = getIt();
  final HelpQuestionRepository helpQuestionRepository = getIt();
  final CompanyRepository companyRepository = getIt();
  bool? hasFilesForExport;
  bool? hasHelpQuestions;

  HelpBloc() : super(HelpLoadInProgressState()) {
    on<HelpLoadInProgressEvent>(_onLoading);
    on<HelpReadyEvent>(_onReady);
    on<HelpClearEvent>(_onClear);
    on<HelpExportFilesFromStorageEvent>(onExportFiles);
    add(HelpLoadInProgressEvent());
  }

  Future<void> _onClear(HelpClearEvent event, Emitter<HelpState> emit) async {
    try {
      String storageDir = await getStorageDir();
      Directory directory = Directory(storageDir);
      Stream<FileSystemEntity> list = directory.list();
      var futures = list.map((FileSystemEntity file) async {
        int fileSize = await File(file.path).length();
        await file.delete();
        return fileSize;
      });
      var values = await Future.wait(await futures.toList());
      int clearedBytes = values.reduce((value, element) => value += element);

      var company = await this.companyRepository.getCurrent();

      emit(HelpClearState(
          hasFilesForExport: hasFilesForExport!,
          hasHelpQuestions: hasHelpQuestions!,
          company: company!,
          clearedBytes: clearedBytes));

      emit(HelpReadyState(
          hasFilesForExport: hasFilesForExport!,
          hasHelpQuestions: hasHelpQuestions!,
          company: company));
    } catch (exception, stackTrace) {
      Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _onLoading(
      HelpLoadInProgressEvent event, Emitter<HelpState> emit) async {
    emit(HelpLoadInProgressState());

    var company = await companyRepository.getCurrent();

    if (company == null) {
      emit(HelpNeedToChooseCompanyState());
      return;
    }

    List<HelpQuestion> helpQuestions =
        await helpQuestionRepository.getList(company);

    hasHelpQuestions = helpQuestions.length > 0;

    hasFilesForExport = await fileExportService.hasFilesForExport();

    emit(HelpReadyState(
        hasFilesForExport: hasFilesForExport!,
        hasHelpQuestions: hasHelpQuestions!,
        company: company));
  }

  Future<void> _onReady(HelpReadyEvent event, Emitter<HelpState> emit) async {
    var company = await companyRepository.getCurrent();

    emit(HelpReadyState(
        hasFilesForExport: hasFilesForExport!,
        hasHelpQuestions: hasHelpQuestions!,
        company: company!));
  }

  Future<void> onExportFiles(
      HelpExportFilesFromStorageEvent event, Emitter<HelpState> emit) async {
    try {
      emit(HelpExportFilesFromStorageState(fileExportService.exportToZip()));
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }
}
