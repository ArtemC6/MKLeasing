import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

abstract class ReviewTemplateFormStepEvent extends Equatable {
  @override
  List<Object?> get props => [Uuid().v4()];
}

class ReviewTemplateFormStepLoadEvent extends ReviewTemplateFormStepEvent {}

class UpdatePageUiEvent extends ReviewTemplateFormStepEvent {}