import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/domain/entities/review_template_step_form_field_entity.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_form_field_model.dart';

class ReviewTemplateStepFormModel {
  final int? localId;
  final int remoteId;
  final int? parentId;
  final String title;
  final String slug;
  final String? description;
  final List<ReviewTemplateStepFormFieldEntity>? fields;

  ReviewTemplateStepFormModel({
    required this.localId,
    required this.remoteId,
    required this.parentId,
    required this.title,
    required this.slug,
    required this.description,
    required this.fields,
  });

  factory ReviewTemplateStepFormModel.fromJson(Map<String, dynamic> json) =>
      ReviewTemplateStepFormModel(
          localId: null,
          remoteId: json['id'],
          parentId: null,
          title: json['title'],
          slug: json['slug'],
          description: json['description'],
          fields: (json['fields'] as List<dynamic>)
              .map((field) => ReviewTemplateStepFormFieldModel.fromJson(field))
              .toList());

  factory ReviewTemplateStepFormModel.fromDBModel(ReviewTemplateForm form) {
    return ReviewTemplateStepFormModel(
      localId: form.id,
      remoteId: form.remoteId,
      parentId: form.parentId,
      title: form.title,
      description: form.description,
      slug: form.slug,
      fields: null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': localId,
        'remote_id': remoteId,
        'parent_id': parentId,
        'title': title,
        'slug': slug,
        'description': description,
        'fields': fields != null
            ? fields!
                .map((field) =>
                    (field as ReviewTemplateStepFormFieldModel).toJson())
                .toList()
            : null,
      };

  ReviewTemplateStepFormModel copyWith({
    int? localId,
    int? remoteId,
    int? parentId,
    String? title,
    String? slug,
    String? description,
    List<ReviewTemplateStepFormFieldEntity>? fields,
  }) =>
      ReviewTemplateStepFormModel(
        localId: localId ?? this.localId,
        remoteId: remoteId ?? this.remoteId,
        parentId: parentId ?? this.parentId,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        description: description ?? this.description,
        fields: fields ?? this.fields,
      );
}
