import 'package:leasing_company/features/articles/domain/entities/article_mini_entity.dart';

class ArticleMiniModel extends ArticleMiniEntity {
  ArticleMiniModel({required int remoteId, required String title})
      : super(remoteId: remoteId, title: title);

  factory ArticleMiniModel.fromJson(Map<String, dynamic> json) =>
      ArticleMiniModel(remoteId: json['id'], title: json['title']);
}
