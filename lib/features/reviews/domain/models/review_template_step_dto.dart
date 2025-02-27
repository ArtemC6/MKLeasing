import 'package:leasing_company/features/reviews/domain/models/review_template_step_form_model.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_multimedia_model.dart';

class ReviewTemplateStepDTO {
  final String title;
  final String? subtitle;
  final String type;
  final bool required;
  final String? comment;
  final String? contentText;
  final String? contentImage;
  final String? contentMask;
  final ReviewTemplateStepFormModel? form;
  final bool requiredCommentWhenSkipping;
  final bool expandable;
  final bool repeatable;
  final List<ReviewTemplateStepMultimediaModel>? multimedia;
  final bool canHaveViolation;
  final int weight;
  final int? formId;
  final int? sectionId;
  final int? localSectionId;
  final bool isSelfCreated;

  ReviewTemplateStepDTO({
    required this.title,
    required this.subtitle,
    required this.type,
    required this.required,
    required this.requiredCommentWhenSkipping,
    required this.expandable,
    required this.repeatable,
    required this.canHaveViolation,
    required this.weight,
    required this.multimedia,
    required this.comment,
    required this.form,
    required this.formId,
    required this.contentText,
    required this.contentImage,
    required this.contentMask,
    required this.sectionId,
    required this.isSelfCreated,
    required this.localSectionId,
  });
}
