import 'package:equatable/equatable.dart';

class ReviewTemplateStepLimitFilesEntity extends Equatable {
  final int min;
  final int max;

  ReviewTemplateStepLimitFilesEntity({required this.min, required this.max});

  ReviewTemplateStepLimitFilesEntity copyWith({
    int? min,
    int? max,
  }) =>
      ReviewTemplateStepLimitFilesEntity(
          min: min ?? this.min, max: max ?? this.max);

  @override
  List<Object?> get props => [min, max];
}
