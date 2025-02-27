import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_model.dart';

class ReviewTemplateProxy {
  final ReviewTemplateModel template;
  final Review? review;

  ReviewTemplateProxy({required this.template, this.review});
}
