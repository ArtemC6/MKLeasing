import 'package:leasing_company/features/reviews/domain/entities/review_template_step_form_field_type_entity.dart';

class ReviewTemplateStepFormFieldTypeModel
    extends ReviewTemplateStepFormFieldTypeEntity {
  ReviewTemplateStepFormFieldTypeModel(
      {required int? id, required String? name, required String keyword})
      : super(id: id, name: name, keyword: keyword);

  factory ReviewTemplateStepFormFieldTypeModel.fromJson(
          Map<String, dynamic> json) =>
      ReviewTemplateStepFormFieldTypeModel(
          id: json['id'], name: json['name'], keyword: json['keyword']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'keyword': keyword,
      };
}
