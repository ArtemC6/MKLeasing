import 'package:leasing_company/features/company/domain/entities/company_config_entity.dart';

class CompanyConfigModel extends CompanyConfigEntity {
  CompanyConfigModel(
      {required bool canCreateArticles,
      required String? phone,
      required String? email})
      : super(canCreateArticles: canCreateArticles, phone: phone, email: email);

  factory CompanyConfigModel.fromJson(dynamic json) => CompanyConfigModel(
        canCreateArticles: json['can_create_articles'],
        email: json['email'],
        phone: json['phone'],
      );

  Map<String, dynamic> toJson() => {
        'can_create_articles': canCreateArticles,
        'email': email,
        'phone': phone,
      };
}
