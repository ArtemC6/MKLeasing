import 'dart:convert';

import 'package:leasing_company/features/reviews/domain/models/review_template_step_form_field_properties_model.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_form_field_type_model.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/domain/entities/review_template_step_form_field_entity.dart';

class ReviewTemplateStepFormFieldModel
    extends ReviewTemplateStepFormFieldEntity {
  ReviewTemplateStepFormFieldModel({
    required int? localId,
    required int remoteId,
    required int? parentId,
    required int? formId,
    required String title,
    required String slug,
    required int weight,
    required ReviewTemplateStepFormFieldTypeModel type,
    required ReviewTemplateStepFormFieldPropertiesModel properties,
  }) : super(
            localId: localId,
            remoteId: remoteId,
            parentId: parentId,
            formId: formId,
            title: title,
            slug: slug,
            weight: weight,
            type: type,
            properties: properties);

  factory ReviewTemplateStepFormFieldModel.fromJson(
          Map<String, dynamic> json) =>
      ReviewTemplateStepFormFieldModel(
          localId: null,
          remoteId: json['id'],
          parentId: null,
          formId: null,
          title: json['title'],
          slug: json['slug'],
          weight: json['weight'],
          type: ReviewTemplateStepFormFieldTypeModel.fromJson(json['type']),
          properties: ReviewTemplateStepFormFieldPropertiesModel.fromJson(
              json['properties']));

  factory ReviewTemplateStepFormFieldModel.fromDBModel(
          ReviewTemplateFormField field) =>
      ReviewTemplateStepFormFieldModel(
          localId: field.id,
          remoteId: field.remoteId,
          parentId: field.parentId,
          formId: field.formId,
          title: field.title,
          slug: field.slug,
          weight: field.weight,
          type: ReviewTemplateStepFormFieldTypeModel(
              id: null, name: null, keyword: field.type),
          properties: ReviewTemplateStepFormFieldPropertiesModel.fromJson(
              jsonDecode(field.properties)));

  Map<String, dynamic> toJson() => {
        'id': localId,
        'remote_id': remoteId,
        'parent_id': parentId,
        'form_id': formId,
        'title': title,
        'slug': slug,
        'weight': weight,
        'type': (type as ReviewTemplateStepFormFieldTypeModel).toJson(),
        'properties':
            (properties as ReviewTemplateStepFormFieldPropertiesModel).toJson(),
      };

  ReviewTemplateStepFormFieldEntity toEntity() =>
      ReviewTemplateStepFormFieldEntity(
          localId: localId,
          remoteId: remoteId,
          parentId: parentId,
          formId: formId,
          title: title,
          slug: slug,
          weight: weight,
          type: type,
          properties: properties);
}
