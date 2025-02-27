import 'package:equatable/equatable.dart';
import 'package:leasing_company/features/reviews/domain/entities/review_template_step_form_field_properties_entity.dart';
import 'package:leasing_company/features/reviews/domain/entities/review_template_step_form_field_type_entity.dart';

class ReviewTemplateStepFormFieldEntity extends Equatable {
  final int? localId;
  final int remoteId;
  final int? parentId;
  final int? formId;
  final String title;
  final String slug;
  final int weight;
  final ReviewTemplateStepFormFieldTypeEntity? type;
  final ReviewTemplateStepFormFieldPropertiesEntity properties;

  ReviewTemplateStepFormFieldEntity({
    required this.localId,
    required this.remoteId,
    required this.parentId,
    required this.formId,
    required this.title,
    required this.slug,
    required this.weight,
    required this.type,
    required this.properties,
  });

  ReviewTemplateStepFormFieldEntity copyWith({
    int? localId,
    int? remoteId,
    int? parentId,
    int? formId,
    String? title,
    String? slug,
    int? weight,
    ReviewTemplateStepFormFieldTypeEntity? type,
    ReviewTemplateStepFormFieldPropertiesEntity? properties,
  }) =>
      ReviewTemplateStepFormFieldEntity(
          localId: localId ?? this.localId,
          remoteId: remoteId ?? this.remoteId,
          parentId: parentId ?? this.parentId,
          formId: formId ?? this.formId,
          title: title ?? this.title,
          slug: slug ?? this.slug,
          weight: weight ?? this.weight,
          type: type ?? this.type,
          properties: properties ?? this.properties);

  @override
  List<Object?> get props => [localId, remoteId, formId];
}
