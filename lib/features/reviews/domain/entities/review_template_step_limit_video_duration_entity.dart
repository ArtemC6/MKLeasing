import 'package:equatable/equatable.dart';

class ReviewTemplateStepLimitVideoDurationEntity extends Equatable {
  final int min;
  final int max;

  ReviewTemplateStepLimitVideoDurationEntity(
      {required this.min, required this.max});

  ReviewTemplateStepLimitVideoDurationEntity copyWith({
    int? min,
    int? max,
  }) =>
      ReviewTemplateStepLimitVideoDurationEntity(
          min: min ?? this.min, max: max ?? this.max);

  @override
  List<Object?> get props => [min, max];
}
