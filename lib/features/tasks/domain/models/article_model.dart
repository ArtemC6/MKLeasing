import 'package:equatable/equatable.dart';

class ArticleModel extends Equatable {
  final int remoteId;
  final String title;

  ArticleModel({required this.remoteId, required this.title});


  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      ArticleModel(remoteId: json['id'], title: json['title']);

  @override
  List<Object?> get props => [remoteId];
}
