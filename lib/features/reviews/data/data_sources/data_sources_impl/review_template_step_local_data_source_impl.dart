import 'package:drift/drift.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/data/data_sources/review_template_step_local_data_source.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';
import 'package:leasing_company/main.dart';

class ReviewTemplateStepLocalDataSourceImpl
    implements ReviewTemplateStepLocalDataSource {
  Future<int> insert(ReviewTemplateStepModel step) async {
    return await database
        .into(database.reviewTemplateSteps)
        .insert(ReviewTemplateStepsCompanion.insert(
          remoteId: Value(step.remoteId),
          remoteUuid: Value(step.remoteUuid),
          parentId: Value(step.parentId),
          companyUuid: step.companyUuid!,
          type: step.type.name,
          title: step.title,
          subtitle: Value(step.subtitle),
          comment: Value(step.comment),
          contentImage: Value(step.contentImage),
          contentMask: Value(step.contentMask),
          contentText: Value(step.contentText),
          required: step.required,
          expandable: step.expandable,
          repeatable: step.repeatable,
          canHaveViolation: step.canHaveViolation,
          weight: step.weight,
          templateId: step.templateId!,
          formId: Value(step.formId),
          multimedia: Value(step.convertMultimediaToString()),
          isSelfCreated: Value(step.isSelfCreated),
          sectionId: Value(step.sectionId),
          localSectionId: Value(step.localSectionId),
          requiredCommentWhenSkipping: Value(step.requiredCommentWhenSkipping),
        ));
  }

  Future<ReviewTemplateStepModel?> getByLocalId(
      String companyUuid, int localId) async {
    var step = await (database.select(database.reviewTemplateSteps)
          ..where((tbl) =>
              tbl.id.equals(localId) & tbl.companyUuid.equals(companyUuid)))
        .getSingleOrNull();

    if (step == null) return null;

    return ReviewTemplateStepModel.fromDBModel(step);
  }

  Future<List<ReviewTemplateStepModel>> getByTemplateLocalId(
      int templateLocalId) async {
    var steps = await (database.select(database.reviewTemplateSteps)
          ..where((tbl) => tbl.templateId.equals(templateLocalId)))
        .get();
    return steps
        .map((step) => ReviewTemplateStepModel.fromDBModel(step))
        .toList();
  }

  Future<bool> update(ReviewTemplateStepModel step) async {
    var updatedCount = await (database.update(database.reviewTemplateSteps)
          ..where((tbl) => tbl.id.equals(step.localId!)))
        .write(ReviewTemplateStepsCompanion(
      remoteId: Value(step.remoteId),
      parentId: Value(step.parentId),
      remoteUuid: Value(step.remoteUuid),
      companyUuid:
          step.companyUuid != null ? Value(step.companyUuid!) : Value.absent(),
      templateId:
          step.templateId != null ? Value(step.templateId!) : Value.absent(),
      reviewUuid: Value(step.reviewUuid),
      type: Value(step.type.name),
      title: Value(step.title),
      subtitle: Value(step.subtitle),
      contentText: Value(step.contentText),
      contentImage: Value(step.contentImage),
      contentMask: Value(step.contentMask),
      weight: Value(step.weight),
      required: Value(step.required),
      expandable: Value(step.expandable),
      repeatable: Value(step.repeatable),
      canHaveViolation: Value(step.canHaveViolation),
      comment: Value(step.comment),
      formId: Value(step.formId),
      sectionId: Value(step.sectionId),
      localSectionId: Value(step.localSectionId),
      isSelfCreated: Value(step.isSelfCreated),
    ));

    return updatedCount > 0;
  }

  @override
  Future<List<int>> insertListSteps(List<ReviewTemplateStepModel> steps) async {
    await database.customUpdate(
      'UPDATE ${database.reviewTemplateSteps.actualTableName} SET weight = weight+${steps.length} WHERE weight >= ${steps.first.weight};',
    );
    List<int> ids = [];
    for (var step in steps) {
      var id = await insert(step);
      ids.add(id);
    }
    return ids;
  }
}
