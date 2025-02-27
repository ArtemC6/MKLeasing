import 'package:camera/camera.dart';
import 'package:leasing_company/features/camera/presentation/camera_page/models/camera_mode.dart';
import 'package:leasing_company/features/reviews/domain/models/review_step_file_dto.dart';

class MediaFileModel {
  final CameraContentType contentType;
  final ReviewStepFileDTO? stepFile;
  final XFile? file;
  final bool isSaved;

  MediaFileModel({
    required this.contentType,
    this.stepFile,
    required this.file,
    required this.isSaved,
  });

  MediaFileModel copyWith({
    ReviewStepFileDTO? stepFile,
    bool? isSaved,
  }) {
    return MediaFileModel(
      stepFile: stepFile ?? this.stepFile,
      file: file,
      contentType: contentType,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}
