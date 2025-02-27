import 'package:equatable/equatable.dart';
import 'package:leasing_company/features/reviews/domain/models/review_step_file_dto.dart';

abstract class MakeDocumentState extends Equatable {
  const MakeDocumentState();

  List<Object> get props => [];
}

class MakeDocumentInitial extends MakeDocumentState {}

class InitializeError extends MakeDocumentState {}

class InitialState extends MakeDocumentState {}

class ExitState extends MakeDocumentState {}

class MakeDocumentToPreviewPhoto extends MakeDocumentState {
  final ReviewStepFileDTO stepFileDTO;

  MakeDocumentToPreviewPhoto({required this.stepFileDTO});
}

class MakeDocumentHaveNotLocationPermission extends MakeDocumentState {}
