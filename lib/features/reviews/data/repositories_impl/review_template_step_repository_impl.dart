import 'dart:io';

import 'package:drift/drift.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/data/data_sources/review_template_step_local_data_source.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_form_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_step_repository.dart';
import 'package:leasing_company/main.dart';
import 'package:leasing_company/services/file_path_provider.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class ReviewTemplateStepRepositoryImpl implements ReviewTemplateStepRepository {
  final ReviewTemplateFormRepository _reviewTemplateFormRepository;
  final ReviewTemplateStepLocalDataSource _localDataSource;

  ReviewTemplateStepRepositoryImpl(this._reviewTemplateFormRepository, this._localDataSource);

  Future<ReviewTemplateStep?> getById(int stepId) async {
    return await (database.select(database.reviewTemplateSteps)..where((tbl) => tbl.id.equals(stepId))).getSingleOrNull();
  }

  Future<ReviewTemplateStep?> getByUuid(String stepUuid) async {
    return await (database.select(database.reviewTemplateSteps)..where((tbl) => tbl.remoteUuid.equals(stepUuid))).getSingleOrNull();
  }

  Future<List<ReviewTemplateStep>> getForTemplate(String companyUuid, int templateId) async {
    return await (database.select(database.reviewTemplateSteps)..where((tbl) => tbl.companyUuid.equals(companyUuid) & tbl.templateId.equals(templateId))).get();
  }

  Future<List<ReviewTemplateStep>> getForTemplateAndReview(String companyUuid, int templateId, String reviewUuid) async {
    return await (database.select(database.reviewTemplateSteps)
          ..where((tbl) => tbl.templateId.equals(templateId))
          ..orderBy([(t) => OrderingTerm(expression: t.weight)]))
        .get();
  }

  Future<List<ReviewTemplateStep>> getStepsForDownload() async {
    return await (database.select(database.reviewTemplateSteps)
          ..where((tbl) =>
              tbl.contentImage.like('http://%') | tbl.contentImage.like('https://%') | tbl.contentMask.like('http://%') | tbl.contentMask.like('https://%')))
        .get();
  }

  Future updateContentImage(String companyUuid, int stepId, String contentImage) async {
    await (database.update(database.reviewTemplateSteps)..where((tbl) => tbl.id.equals(stepId)))
        .write(ReviewTemplateStepsCompanion(contentImage: Value(contentImage)));
  }

  Future updateContentMask(String companyUuid, int stepId, String contentMask) async {
    await (database.update(database.reviewTemplateSteps)..where((tbl) => tbl.id.equals(stepId)))
        .write(ReviewTemplateStepsCompanion(contentMask: Value(contentMask)));
  }

  Future<ReviewTemplateStep> create({
    required String companyUuid,
    int? remoteId,
    String? remoteUuid,
    int? parentId,
    required int templateId,
    String? reviewUuid,
    required String title,
    required String? subtitle,
    required String type,
    String? contentImage,
    String? contentMask,
    String? contentText,
    String? comment,
    int? formId,
    required bool required,
    required bool requiredCommentWhenSkipping,
    required bool expandable,
    required bool repeatable,
    required bool canHaveViolation,
    required int weight,
    required int? sectionId,
  }) async {
    final id = await database.into(database.reviewTemplateSteps).insert(ReviewTemplateStepsCompanion.insert(
          companyUuid: companyUuid,
          parentId: Value(parentId),
          remoteId: Value(remoteId),
          remoteUuid: Value(remoteUuid ?? Uuid().v4()),
          templateId: templateId,
          reviewUuid: Value(reviewUuid),
          contentImage: Value(contentImage),
          contentMask: Value(contentMask),
          contentText: Value(contentText),
          comment: Value(comment),
          formId: Value(formId),
          title: title,
          subtitle: Value(subtitle),
          type: type,
          required: required,
          expandable: expandable,
          repeatable: repeatable,
          canHaveViolation: canHaveViolation,
          weight: weight,
          requiredCommentWhenSkipping: Value(requiredCommentWhenSkipping),
          sectionId: Value(sectionId),
        ));

    return (await getById(id))!;
  }

  Future<ReviewTemplateStep> createCopyOf(String companyUuid, int id, {int? templateId, String? reviewUuid}) async {
    final step = (await getById(id))!;

    ReviewTemplateForm? form;

    if (step.formId != null) {
      form = await _reviewTemplateFormRepository.createCopyOf(step.formId!);
    }

    String storagePath = await getStorageDir();

    String? contentImage;
    if (step.contentImage != null && step.contentImage?.startsWith('http://') == false && step.contentImage?.startsWith('https://') == false) {
      final previousContentImagePath = join(storagePath, step.contentImage);
      final f = File(previousContentImagePath);
      if (await f.exists()) {
        final newContentImagePath = join(storagePath, Uuid().v4(), '.', extension(step.contentImage!));
        await f.copy(newContentImagePath);
        contentImage = newContentImagePath;
      }
    } else {
      contentImage = step.contentImage;
    }

    String? contentMask;
    if (step.contentMask != null && step.contentMask?.startsWith('http://') == false && step.contentMask?.startsWith('https://') == false) {
      final previousContentMaskPath = join(storagePath, step.contentMask);
      final f = File(previousContentMaskPath);
      if (await f.exists()) {
        final newContentMaskPath = join(storagePath, Uuid().v4(), '.', extension(step.contentMask!));
        await f.copy(newContentMaskPath);
        contentMask = newContentMaskPath;
      }
    } else {
      contentMask = step.contentMask;
    }

    final newStep = await create(
      companyUuid: companyUuid,
      remoteId: step.remoteId,
      remoteUuid: step.remoteUuid,
      parentId: step.id,
      templateId: templateId ?? step.templateId,
      reviewUuid: reviewUuid,
      formId: form?.id,
      comment: step.comment,
      contentImage: contentImage,
      contentMask: contentMask,
      contentText: step.contentText,
      title: step.title,
      subtitle: step.subtitle,
      type: step.type,
      required: step.required,
      expandable: step.expandable,
      repeatable: step.repeatable,
      canHaveViolation: step.canHaveViolation,
      weight: step.weight,
      requiredCommentWhenSkipping: step.requiredCommentWhenSkipping,
      sectionId: step.sectionId, 
    );

    return newStep;
  }

  Future deleteByTemplateId(int id) async {
    final stepsWithImageOrMask = await (database.select(database.reviewTemplateSteps)
          ..where(
            (tbl) => tbl.templateId.equals(id) & (tbl.contentImage.isNotNull() | tbl.contentMask.isNotNull()),
          ))
        .get();

    final storageDir = await getStorageDir();

    final futures = stepsWithImageOrMask.map((e) async {
      if (e.contentImage != null && e.contentImage?.startsWith('http://') == false && e.contentImage?.startsWith('https://') == false) {
        final f = File(join(storageDir, e.contentImage));
        if (await f.exists()) {
          await f.delete();
        }
      }

      if (e.contentMask != null && e.contentMask?.startsWith('http://') == false && e.contentMask?.startsWith('https://') == false) {
        final f = File(join(storageDir, e.contentMask));
        if (await f.exists()) {
          await f.delete();
        }
      }
    }).toList();

    await Future.wait(futures);

    final stepsWithForms = await (database.select(database.reviewTemplateSteps)
          ..where(
            (tbl) => tbl.templateId.equals(id) & tbl.formId.isNotNull(),
          ))
        .get();

    List<int> formsIds = stepsWithForms.map((e) => e.formId).whereType<int>().toList();

    await _reviewTemplateFormRepository.deleteByIds(formsIds);

    return await (database.delete(database.reviewTemplateSteps)..where((tbl) => tbl.templateId.equals(id))).go();
  }

  Future<int> insert(ReviewTemplateStepModel step) {
    return _localDataSource.insert(step);
  }

  Future<ReviewTemplateStepModel?> getByLocalId(String companyUuid, int localId) {
    return _localDataSource.getByLocalId(companyUuid, localId);
  }

  Future<List<ReviewTemplateStepModel>> getByTemplateLocalId(int templateLocalId) {
    return _localDataSource.getByTemplateLocalId(templateLocalId);
  }

  @override
  Future<bool> update(ReviewTemplateStepModel step) {
    return _localDataSource.update(step);
  }

  @override
  Future<List<int>> insertListSteps(List<ReviewTemplateStepModel> steps) => _localDataSource.insertListSteps(steps);
}
