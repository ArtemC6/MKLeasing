import 'package:equatable/equatable.dart';

abstract class PreviewPhotoEvent extends Equatable {
  const PreviewPhotoEvent();

  List<Object?> get props => [];
}

class InitEvent extends PreviewPhotoEvent {}

class ApplyEvent extends PreviewPhotoEvent {}

class DenyEvent extends PreviewPhotoEvent {}
