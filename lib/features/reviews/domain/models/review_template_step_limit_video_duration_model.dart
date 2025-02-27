import 'package:leasing_company/features/reviews/domain/entities/review_template_step_limit_video_duration_entity.dart';

class ReviewTemplateStepLimitVideoDurationModel
    extends ReviewTemplateStepLimitVideoDurationEntity {
  ReviewTemplateStepLimitVideoDurationModel(
      {required int min, required int max})
      : super(min: min, max: max);

  factory ReviewTemplateStepLimitVideoDurationModel.fromJson(
          Map<String, dynamic> json) =>
      ReviewTemplateStepLimitVideoDurationModel(
          min: json['min'], max: json['max']);

  Map<String, dynamic> toJson() => {'min': min, 'max': max};
}
