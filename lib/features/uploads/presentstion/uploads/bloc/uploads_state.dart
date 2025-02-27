import 'package:equatable/equatable.dart';
import 'package:leasing_company/features/uploads/presentstion/uploads/bloc/uploads_bloc.dart';
import 'package:uuid/uuid.dart';

abstract class UploadsState extends Equatable {
  @override
  List<Object> get props => [Uuid().v4()];
}

// Загрузка списка...
class UploadsLoadInProgressState extends UploadsState {}

// Отображение списка
class UploadsReadyState extends UploadsState {
  final List<ReviewGroupUploads> reviewGroupsStream;

  UploadsReadyState(this.reviewGroupsStream);
}

// Произошла ошибка
class UploadsFailureState extends UploadsState {}
