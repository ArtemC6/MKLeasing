import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/data/data_sources/review_template_step_form_field_local_data_source.dart';
import 'package:leasing_company/features/reviews/domain/entities/review_template_step_form_field_entity.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_form_field_model.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_form_field_properties_model.dart';
import 'package:leasing_company/main.dart';

class ReviewTemplateStepFormFieldLocalDataSourceImpl
    implements ReviewTemplateStepFormFieldLocalDataSource {
  @override
  Future<int> insert(
      {required String companyUuid,
      required int formLocalId,
      required ReviewTemplateStepFormFieldEntity field}) async {
      return await database
          .into(database.reviewTemplateFormFields)
          .insert(ReviewTemplateFormFieldsCompanion.insert(
              companyUuid: companyUuid,
              remoteId: field.remoteId,
              parentId: Value(field.parentId),
              slug: field.slug,
              title: field.title,
              weight: field.weight,
              type: field.type!.keyword,
              formId: formLocalId,
              properties: jsonEncode(ReviewTemplateStepFormFieldPropertiesModel(
                required: field.properties.required,
                searchable: field.properties.searchable,
                plusTime: field.properties.plusTime,
                options: field.properties.options,
                content: field.properties.content,
                bigText: field.properties.bigText,
              ).toJson())));
  }

  Future<ReviewTemplateStepFormFieldModel?> getByLocalId(int localId) async {
    var field = await (database.select(database.reviewTemplateFormFields)
          ..where((tbl) => tbl.id.equals(localId)))
        .getSingleOrNull();

    if (field == null) return null;

    return ReviewTemplateStepFormFieldModel.fromDBModel(field);
  }

  Future<List<ReviewTemplateStepFormFieldModel>> getByFormsLocalIds(
      List<int> formsIdsWithFields) async {
    var fields = await (database.select(database.reviewTemplateFormFields)
          ..where((tbl) => tbl.formId.isIn(formsIdsWithFields)))
        .get();

    return fields
        .map((f) => ReviewTemplateStepFormFieldModel.fromDBModel(f))
        .toList();
  }
}
