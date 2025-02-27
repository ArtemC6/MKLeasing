import 'package:equatable/equatable.dart';

class ReviewTemplateStepFormFieldTypeEntity extends Equatable {
  final int? id;
  final String? name;
  final String keyword;

  ReviewTemplateStepFormFieldTypeEntity(
      {required this.id, required this.name, required this.keyword});

  ReviewTemplateStepFormFieldTypeEntity copyWith({
    int? id,
    String? name,
    String? keyword,
  }) =>
      ReviewTemplateStepFormFieldTypeEntity(
          id: id ?? this.id,
          name: name ?? this.name,
          keyword: keyword ?? this.keyword);

  @override
  List<Object?> get props => [id, name, keyword];
}
