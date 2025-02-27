import 'package:leasing_company/features/reviews/domain/entities/review_template_step_limit_files_entity.dart';

class ReviewTemplateStepLimitFilesModel
    extends ReviewTemplateStepLimitFilesEntity {
  ReviewTemplateStepLimitFilesModel({required int min, required int max})
      : super(min: min, max: max);

  factory ReviewTemplateStepLimitFilesModel.fromJson(
          Map<String, dynamic> json) =>
      ReviewTemplateStepLimitFilesModel(min: json['min'], max: json['max']);

  Map<String, dynamic> toJson() => {'min': min, 'max': max};
}
