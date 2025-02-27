import 'package:leasing_company/features/reviews/domain/entities/review_template_step_form_field_properties_entity.dart';

class ReviewTemplateStepFormFieldPropertiesModel
    extends ReviewTemplateStepFormFieldPropertiesEntity {
  ReviewTemplateStepFormFieldPropertiesModel(
      {required bool? required,
      required bool? bigText,
      required bool? plusTime,
      required bool? searchable,
      required String? content,
      required List<String>? options})
      : super(
            required: required,
            bigText: bigText,
            plusTime: plusTime,
            searchable: searchable,
            content: content,
            options: options);

  factory ReviewTemplateStepFormFieldPropertiesModel.fromJson(
          Map<String, dynamic> json) =>
      ReviewTemplateStepFormFieldPropertiesModel(
          required: json.containsKey('required') ? json['required'] : null,
          bigText: json.containsKey('big_text') ? json['big_text'] : null,
          plusTime: json.containsKey('plus_time') ? json['plus_time'] : null,
          searchable:
              json.containsKey('searchable') ? json['searchable'] : null,
          content: json.containsKey('content') ? json['content'] : null,
          options: json.containsKey('options') && json['options'] != null
              ? (json['options'] as List<dynamic>).cast<String>()
              : null);

  Map<String, dynamic> toJson() => {
        'required': required,
        'big_text': bigText,
        'plus_time': plusTime,
        'searchable': searchable,
        'content': content,
        'options': options,
      };
}
