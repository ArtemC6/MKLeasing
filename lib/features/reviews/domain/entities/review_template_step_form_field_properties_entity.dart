import 'package:equatable/equatable.dart';

class ReviewTemplateStepFormFieldPropertiesEntity extends Equatable {
  final bool? required;
  final bool? bigText;
  final bool? plusTime;
  final bool? searchable;
  final String? content;
  final List<String>? options;

  ReviewTemplateStepFormFieldPropertiesEntity(
      {required this.required,
      required this.bigText,
      required this.plusTime,
      required this.searchable,
      required this.content,
      required this.options});

  ReviewTemplateStepFormFieldPropertiesEntity copyWith({
    bool? required,
    bool? bigText,
    bool? plusTime,
    bool? searchable,
    String? content,
    List<String>? options,
  }) =>
      ReviewTemplateStepFormFieldPropertiesEntity(
          required: required ?? this.required,
          bigText: bigText ?? this.bigText,
          plusTime: plusTime ?? this.plusTime,
          searchable: searchable ?? this.searchable,
          content: content ?? this.content,
          options: options ?? this.options);

  @override
  List<Object?> get props =>
      [required, bigText, plusTime, searchable, content, options];
}
