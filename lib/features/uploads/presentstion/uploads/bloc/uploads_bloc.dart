import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_step_file_repository.dart';
import 'package:leasing_company/features/reviews/domain/repositories/review_template_repository.dart';
import 'package:leasing_company/features/uploads/domain/repositories/upload_repository.dart';
import 'uploads_event.dart';
import 'uploads_state.dart';

class UploadsBloc extends Bloc<UploadsEvent, UploadsState> {
  final UploadRepository _uploadRepository;
  final ReviewRepository _reviewRepository;
  final ReviewTemplateRepository _reviewTemplateRepository;
  final ReviewStepFileRepository _reviewStepFileRepository;

  Timer? timer;

  UploadsBloc(
    this._uploadRepository,
    this._reviewRepository,
    this._reviewTemplateRepository,
    this._reviewStepFileRepository,
  ) : super(UploadsLoadInProgressState()) {
    _uploadRepository.get().then((value) => handleUploadsUpdate(value));
    timer = Timer.periodic(
        Duration(seconds: 3),
        (t) => _uploadRepository
            .get()
            .then((value) => handleUploadsUpdate(value)));
  }

  Future handleUploadsUpdate(List<Upload> uploads) async {
    Set<String> reviewUuids = Set<String>();
    uploads.forEach((upload) => reviewUuids.add(upload.reviewUuid));

    final reviews = await _reviewRepository.getByUuids(reviewUuids.toList());

    final files = await _reviewStepFileRepository.get();

    List<ReviewGroupUploads> groups =
        await Future.wait(reviews.map((review) async {
      final groupUploads =
          uploads.where((u) => u.reviewUuid == review.uuid).toList();
      final template = (await _reviewTemplateRepository.getById(
          review.companyUuid, review.templateId))!;

      final groupFiles =
          files.where((f) => f.reviewUuid == review.uuid).toList();
      return ReviewGroupUploads(
          review: review,
          template: template,
          uploads: groupUploads,
          files: groupFiles);
    }).toList());

    emit(UploadsReadyState(groups));
  }

  @override
  Future<void> close() async {
    timer?.cancel();
    timer = null;
    return super.close();
  }
}

class ReviewGroupUploads {
  Review review;
  ReviewTemplate template;
  List<Upload> uploads;
  List<ReviewStepFile> files;

  ReviewGroupUploads({
    required this.review,
    required this.template,
    required this.uploads,
    required this.files,
  });
}
