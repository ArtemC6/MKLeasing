import 'package:drift/drift.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/models/step_model.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_section_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_repository.dart';
import 'package:uuid/uuid.dart';

class CopySectionUseCase {
  final ReviewTemplateSectionRepository _sectionRepository;
  final ReviewTemplateStepRepository _stepRepository;

  CopySectionUseCase(this._sectionRepository, this._stepRepository);

  Future<int> call(
      ReviewSection newSection, List<StepModel> sectionSteps) async {
    final localSectionId = await _sectionRepository.insert(newSection.copyWith(
        uuid: Uuid().v4(), remoteId: Value(null), isSelfCreated: true));
    final copiedSteps = sectionSteps
        .map((e) => e.copyWith(
              remoteUuid: Uuid().v4(),
              localSectionId: localSectionId,
              weight: e.weight + sectionSteps.length,
              isSelfCreated: true,
              needToSetNullToSectionId: true,
              needToSetNullToRemoteId: true,
            ))
        .toList();
    await _stepRepository.insertListSteps(copiedSteps);
    return localSectionId;
  }
}
