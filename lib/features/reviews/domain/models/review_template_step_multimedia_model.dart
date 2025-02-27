import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/content_preview/content_type_info_widget.dart';

class ReviewTemplateStepMultimediaModel {
  final StepContentType stepContentType;
  final bool multiple;
  final int minCount;
  final int maxCount;
  final int? minDuration;
  final int? maxDuration;

  ReviewTemplateStepMultimediaModel({
    required this.stepContentType,
    required this.multiple,
    required this.minCount,
    required this.maxCount,
    this.minDuration,
    this.maxDuration,
  });

  static ReviewTemplateStepMultimediaModel fromJson(
    Map json,
    String multimediaTypeKeyword,
  ) {
    return ReviewTemplateStepMultimediaModel(
      stepContentType: StepContentTypeExt.parse(multimediaTypeKeyword),
      multiple: json['multiple'],
      minCount: json['min_count'],
      maxCount: json['max_count'],
      minDuration: json['min_duration'],
      maxDuration: json['max_duration'],
    );
  }

  Map toJson() {
    return {
      'multiple': multiple,
      'min_count': minCount,
      'max_count': maxCount,
      'min_duration': minDuration,
      'max_duration': maxDuration,
    };
  }
}
