import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/services/file_export_service.dart';

abstract class HelpState {}

abstract class AbstractHelpReadyState extends HelpState {
  final CompanyEntity company;
  final bool hasFilesForExport;
  final bool hasHelpQuestions;

  AbstractHelpReadyState(
      {required this.hasFilesForExport,
      required this.hasHelpQuestions,
      required this.company});
}

class HelpLoadInProgressState extends HelpState {}

class HelpReadyState extends AbstractHelpReadyState {
  HelpReadyState(
      {required bool hasFilesForExport,
      required bool hasHelpQuestions,
      required CompanyEntity company})
      : super(
            company: company,
            hasFilesForExport: hasFilesForExport,
            hasHelpQuestions: hasHelpQuestions);
}

class HelpClearState extends AbstractHelpReadyState {
  final int clearedBytes;

  HelpClearState(
      {required bool hasFilesForExport,
      required bool hasHelpQuestions,
      required CompanyEntity company,
      required this.clearedBytes})
      : super(
            company: company,
            hasFilesForExport: hasFilesForExport,
            hasHelpQuestions: hasHelpQuestions);
}

class HelpExportFilesFromStorageState extends HelpState {
  final Stream<ExportProgress> exportProgress;

  HelpExportFilesFromStorageState(this.exportProgress);
}

class HelpNeedToChooseCompanyState extends HelpState {}
