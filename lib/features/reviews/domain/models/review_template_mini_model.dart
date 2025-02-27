import 'package:leasing_company/features/reviews/domain/entities/review_template_mini_entity.dart';

class ReviewTemplateMiniModel extends ReviewTemplateMiniEntity {
  ReviewTemplateMiniModel(
      {required int remoteId, required String name, required int articleTypeId})
      : super(remoteId: remoteId, name: name, articleTypeId: articleTypeId);

  factory ReviewTemplateMiniModel.fromJson(Map<String, dynamic> json) =>
      ReviewTemplateMiniModel(
          remoteId: json['id'],
          name: json['name'],
          articleTypeId: json['article_type_id']);

  ReviewTemplateMiniEntity toEntity() => ReviewTemplateMiniEntity(
      remoteId: remoteId, name: name, articleTypeId: articleTypeId);
}
