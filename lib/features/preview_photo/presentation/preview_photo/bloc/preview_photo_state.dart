import 'package:equatable/equatable.dart';

abstract class PreviewPhotoState extends Equatable {
  const PreviewPhotoState();

  List<Object> get props => [];
}

class PreviewPhotoInitial extends PreviewPhotoState {}

class ApplyState extends PreviewPhotoState {}

class DenyState extends PreviewPhotoState {}
