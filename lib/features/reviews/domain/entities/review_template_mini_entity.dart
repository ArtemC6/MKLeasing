import 'package:equatable/equatable.dart';

class ReviewTemplateMiniEntity extends Equatable {
  final int remoteId;
  final String name;
  final int articleTypeId;

  ReviewTemplateMiniEntity(
      {required this.remoteId,
      required this.name,
      required this.articleTypeId});

  @override
  List<Object?> get props => [remoteId];
}
