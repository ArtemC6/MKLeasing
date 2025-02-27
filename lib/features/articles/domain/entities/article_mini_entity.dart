import 'package:equatable/equatable.dart';

class ArticleMiniEntity extends Equatable {
  final int remoteId;
  final String title;

  ArticleMiniEntity({required this.remoteId, required this.title});

  @override
  List<Object?> get props => [remoteId];
}
