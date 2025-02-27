import 'package:equatable/equatable.dart';

abstract class MakeDocumentEvent extends Equatable {
  const MakeDocumentEvent();

  List<Object> get props => [];
}

class InitializeEvent extends MakeDocumentEvent {}
