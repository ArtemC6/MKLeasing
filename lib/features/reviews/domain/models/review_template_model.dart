import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/domain/models/review_template_step_model.dart';

class ReviewTemplateModel {
  final int? localId;
  final int remoteId;
  final int? parentId;
  final String name;
  final String? description;
  final bool expandable;
  final bool repeatable;
  final bool private;
  final bool isRework;
  final bool rejectionAvailable;
  final bool delegationAvailable;
  final List<ReviewTemplateStepModel>? steps;
  final List<ReviewSection>? sections;
  final bool simpleSignatureEnabled;
  final String? simpleSignatureFile;
  final bool isOpened;

  ReviewTemplateModel({
    required this.localId,
    required this.remoteId,
    required this.parentId,
    required this.name,
    required this.description,
    required this.expandable,
    required this.repeatable,
    required this.private,
    required this.isRework,
    required this.rejectionAvailable,
    required this.delegationAvailable,
    required this.steps,
    required this.sections,
    required this.simpleSignatureEnabled,
    required this.simpleSignatureFile,
    this.isOpened = false,
  });

  factory ReviewTemplateModel.fromJson(Map<String, dynamic> json) {
    return ReviewTemplateModel(
      localId: null,
      remoteId: json['id'],
      parentId: null,
      name: json['name'],
      description: json['description'],
      expandable: json['expandable'],
      repeatable: json['repeatable'],
      private: json['private'],
      isRework: json['is_rework'],
      steps: (json['steps'] as List<dynamic>).map((step) => ReviewTemplateStepModel.fromJson(step)).toList(),
      sections: json['section'] != null ? (json['section'] as List<dynamic>).map((e) => ReviewSection.fromJson(e)).toList() : null,
      rejectionAvailable: json['rejection_available'],
      delegationAvailable: json['delegation_available'],
      simpleSignatureEnabled: json['simple_signature_enabled'],
      simpleSignatureFile: json['simple_signature_file'],
      isOpened: json['is_opened'] ?? true,
    );
  }

  factory ReviewTemplateModel.fromDBModel(ReviewTemplate dbModel) {
    return ReviewTemplateModel(
      localId: dbModel.id,
      parentId: dbModel.parentId,
      remoteId: dbModel.remoteId,
      name: dbModel.name,
      description: dbModel.description,
      expandable: dbModel.expandable,
      repeatable: dbModel.repeatable,
      private: dbModel.private,
      steps: null,
      sections: null,
      rejectionAvailable: dbModel.rejectionAvailable,
      delegationAvailable: dbModel.delegationAvailable,
      isRework: dbModel.isRework,
      simpleSignatureEnabled: dbModel.simpleSignatureEnabled ?? true,
      simpleSignatureFile: dbModel.simpleSignatureFile,
      isOpened: dbModel.isOpened,
    );
  }

  ReviewTemplateModel copyWith({
    int? localId,
    int? remoteId,
    int? parentId,
    String? name,
    String? description,
    bool? expandable,
    bool? repeatable,
    bool? private,
    bool? isRework,
    bool? rejectionAvailable,
    bool? delegationAvailable,
    List<ReviewTemplateStepModel>? steps,
    List<ReviewSection>? sections,
    bool? simpleSignatureEnabled,
    String? simpleSignatureFile,
  }) =>
      ReviewTemplateModel(
        localId: localId ?? this.localId,
        remoteId: remoteId ?? this.remoteId,
        parentId: parentId ?? this.parentId,
        name: name ?? this.name,
        description: description ?? this.description,
        expandable: expandable ?? this.expandable,
        repeatable: repeatable ?? this.repeatable,
        private: private ?? this.private,
        steps: steps ?? this.steps,
        sections: sections ?? this.sections,
        rejectionAvailable: rejectionAvailable ?? this.rejectionAvailable,
        delegationAvailable: delegationAvailable ?? this.delegationAvailable,
        isRework: isRework ?? this.isRework,
        simpleSignatureEnabled: simpleSignatureEnabled ?? this.simpleSignatureEnabled,
        simpleSignatureFile: simpleSignatureFile ?? this.simpleSignatureFile,
        isOpened: isOpened,
      );
}
