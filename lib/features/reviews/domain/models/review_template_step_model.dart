import 'dart:convert';

import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/make_report/presentation/make_report_page/widgets/content_preview/content_type_info_widget.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_form_model.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_multimedia_model.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_type.dart';

class ReviewTemplateStepModel {
  final int? localId;
  final int? remoteId;
  final String? remoteUuid;
  final int? parentId;
  final String? companyUuid;
  final String? reviewUuid;
  final int? templateId;
  final String title;
  final String? subtitle;
  final String? contentText;
  final String? contentImage;
  final String? contentMask;
  final String? comment;
  final bool required;
  final bool requiredCommentWhenSkipping;
  final bool expandable;
  final bool repeatable;
  final bool canHaveViolation;
  final int weight;
  final ReviewTemplateStepType type;
  final int? formId;
  final ReviewTemplateStepFormModel? form;
  final List<ReviewTemplateStepMultimediaModel>? multimedia;
  final int? sectionId;
  final int? localSectionId;
  final bool isSelfCreated;

  ReviewTemplateStepModel({
    required this.localId,
    required this.remoteId,
    required this.remoteUuid,
    required this.parentId,
    required this.companyUuid,
    required this.reviewUuid,
    required this.templateId,
    required this.title,
    required this.subtitle,
    required this.contentText,
    required this.contentImage,
    required this.contentMask,
    required this.comment,
    required this.required,
    required this.requiredCommentWhenSkipping,
    required this.expandable,
    required this.repeatable,
    required this.canHaveViolation,
    required this.weight,
    required this.type,
    required this.formId,
    required this.form,
    required this.multimedia,
    required this.sectionId,
    required this.isSelfCreated,
    required this.localSectionId,
  });

  factory ReviewTemplateStepModel.fromJson(Map<String, dynamic> json) {
    List<ReviewTemplateStepMultimediaModel>? listMultimediaTypes = [];
    if (json['multimedia'] != null) {
      json['multimedia'].forEach((key, value) {
        listMultimediaTypes?.add(ReviewTemplateStepMultimediaModel(
          stepContentType: StepContentTypeExt.parse(key as String),
          multiple: value['multiple'],
          minCount: value['min_count'],
          maxCount: value['max_count'],
          minDuration: value['min_duration'],
          maxDuration: value['max_duration'],
        ));
      });
    }
    if (listMultimediaTypes.isEmpty) listMultimediaTypes = null;
    return ReviewTemplateStepModel(
      localId: null,
      remoteId: json['id'],
      remoteUuid: json['uuid'],
      parentId: null,
      companyUuid: null,
      reviewUuid: null,
      templateId: null,
      title: json['title'],
      subtitle: json['subtitle'],
      contentText: json['content_text'],
      contentImage: json['content_image'],
      contentMask: json['content_mask'],
      comment: json['comment'],
      required: json['required'],
      requiredCommentWhenSkipping: json['required_comment_when_skipping'],
      expandable: json['expandable'],
      repeatable: json['repeatable'],
      canHaveViolation: json['can_have_violation'],
      weight: json['weight'],
      type: ReviewTemplateStepTypeExt.byKeyword(json['type']),
      formId: json['form_id'],
      form: json['form'] != null ? ReviewTemplateStepFormModel.fromJson(json['form']) : null,
      multimedia: listMultimediaTypes,
      sectionId: json['review_template_section_id'],
      isSelfCreated: false,
      localSectionId: null,
    );
  }

  factory ReviewTemplateStepModel.fromDBModel(ReviewTemplateStep step) {
    List<ReviewTemplateStepMultimediaModel>? listMultimediaTypes = [];
    if (step.multimedia != null) {
      jsonDecode(step.multimedia!).forEach((key, value) {
        listMultimediaTypes?.add(ReviewTemplateStepMultimediaModel(
          stepContentType: StepContentTypeExt.parse(key as String),
          multiple: value['multiple'],
          minCount: value['min_count'],
          maxCount: value['max_count'],
          minDuration: value['min_duration'],
          maxDuration: value['max_duration'],
        ));
      });
    }
    if (listMultimediaTypes.isEmpty) listMultimediaTypes = null;
    return ReviewTemplateStepModel(
      localId: step.id,
      remoteId: step.remoteId,
      remoteUuid: step.remoteUuid,
      parentId: step.parentId,
      companyUuid: step.companyUuid,
      templateId: step.templateId,
      reviewUuid: step.reviewUuid,
      title: step.title,
      subtitle: step.subtitle,
      comment: step.comment,
      contentText: step.contentText,
      contentMask: step.contentMask,
      contentImage: step.contentImage,
      weight: step.weight,
      type: ReviewTemplateStepTypeExt.byKeyword(step.type),
      formId: step.formId,
      form: null,
      required: step.required,
      requiredCommentWhenSkipping: step.requiredCommentWhenSkipping,
      expandable: step.expandable,
      repeatable: step.repeatable,
      canHaveViolation: step.canHaveViolation,
      multimedia: listMultimediaTypes,
      sectionId: step.sectionId,
      isSelfCreated: step.isSelfCreated,
      localSectionId: step.localSectionId,
    );
  }

  String? convertMultimediaToString() {
    if (multimedia == null) return null;
    Map<String, dynamic> mapMultimedia = Map.identity();
    multimedia?.forEach((element) {
      mapMultimedia[element.stepContentType.name] = element.toJson();
    });
    return jsonEncode(mapMultimedia);
  }

  Map<String, dynamic> toJson() => {
        'id': localId,
        'remote_id': remoteId,
        'remote_uuid': remoteUuid,
        'parent_id': null,
        'company_uuid': null,
        'review_uuid': null,
        'template_id': null,
        'title': title,
        'subtitle': subtitle,
        'content_text': contentText,
        'content_image': contentImage,
        'content_mask': contentMask,
        'comment': comment,
        'required': required,
        'expandable': expandable,
        'repeatable': repeatable,
        'can_have_violation': canHaveViolation,
        'weight': weight,
        'type': type,
        'form_id': form?.localId,
        'form': (form != null) ? (form as ReviewTemplateStepFormModel).toJson() : null,
        'multimedia': multimedia,
      };

  ReviewTemplateStepModel copyWith({
    int? localId,
    int? remoteId,
    String? remoteUuid,
    int? parentId,
    String? companyUuid,
    String? reviewUuid,
    int? templateId,
    String? title,
    String? subtitle,
    String? contentText,
    String? contentImage,
    String? contentMask,
    String? comment,
    bool? required,
    bool? expandable,
    bool? repeatable,
    bool? canHaveViolation,
    int? weight,
    ReviewTemplateStepType? type,
    int? formId,
    ReviewTemplateStepFormModel? form,
    bool? requiredCommentWhenSkipping,
    List<ReviewTemplateStepMultimediaModel>? multimedia,
    int? sectionId,
    int? localSectionId,
    bool? isSelfCreated,
    bool? needToSetNullToSectionId,
    bool? needToSetNullToRemoteId,
    bool? needToSetNullToRemoteUuid,
  }) =>
      ReviewTemplateStepModel(
        localId: localId ?? this.localId,
        remoteId: needToSetNullToRemoteId == true ? null : remoteId ?? this.remoteId,
        remoteUuid: needToSetNullToRemoteUuid == true ? null : remoteUuid ?? this.remoteUuid,
        parentId: parentId ?? this.parentId,
        companyUuid: companyUuid ?? this.companyUuid,
        reviewUuid: reviewUuid ?? this.reviewUuid,
        templateId: templateId ?? this.templateId,
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        contentText: contentText ?? this.contentText,
        contentImage: contentImage ?? this.contentImage,
        contentMask: contentMask ?? this.contentMask,
        comment: comment ?? this.comment,
        required: required ?? this.required,
        expandable: expandable ?? this.expandable,
        repeatable: repeatable ?? this.repeatable,
        canHaveViolation: canHaveViolation ?? this.canHaveViolation,
        weight: weight ?? this.weight,
        type: type ?? this.type,
        formId: formId ?? this.formId,
        form: form ?? this.form,
        requiredCommentWhenSkipping: requiredCommentWhenSkipping ?? this.requiredCommentWhenSkipping,
        multimedia: multimedia ?? this.multimedia,
        sectionId: needToSetNullToSectionId == true ? null : sectionId ?? this.sectionId,
        isSelfCreated: isSelfCreated ?? this.isSelfCreated,
        localSectionId: localSectionId ?? this.localSectionId,
      );
}
