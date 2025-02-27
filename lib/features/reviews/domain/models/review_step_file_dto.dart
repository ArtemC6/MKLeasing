import 'package:leasing_company/core/drift/drift.dart';

class ReviewStepFileDTO {
  final String? fileUuid;
  final int? stepId;
  final String? type;
  final String? path;
  final String? compressedPath;
  String? comment;
  final String? hash;
  final DateTime? createdAt;
  final DateTime? onDeviceCreatedAt;

  ReviewStepFileDTO({
    this.fileUuid,
    this.stepId,
    this.type,
    this.path,
    this.compressedPath,
    this.comment,
    this.hash,
    this.createdAt,
    this.onDeviceCreatedAt,
  });

  static ReviewStepFileDTO fromReviewStepFile(ReviewStepFile stepFile) {
    return ReviewStepFileDTO(
      fileUuid: stepFile.uuid,
      type: stepFile.type,
      path: stepFile.path,
      comment: stepFile.comment,
      compressedPath: stepFile.compressedPath,
    );
  }

  ReviewStepFileDTO copyWith({
    String? fileUuid,
    int? stepId,
    String? type,
    String? path,
    String? compressedPath,
    String? comment,
    String? hash,
    DateTime? createdAt,
    DateTime? onDeviceCreatedAt,
  }) {
    return ReviewStepFileDTO(
      fileUuid: fileUuid ?? this.fileUuid,
      stepId: stepId ?? this.stepId,
      type: type ?? this.type,
      path: path ?? this.path,
      compressedPath: compressedPath ?? this.compressedPath,
      comment: comment ?? this.comment,
      hash: hash ?? this.hash,
      createdAt: createdAt ?? this.createdAt,
      onDeviceCreatedAt: onDeviceCreatedAt ?? this.onDeviceCreatedAt,
    );
  }
}
