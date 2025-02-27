class Config {
  final UsersConfig users;
  final ArticlesConfig articles;
  final String? supportEmail;
  final String? supportPhone;
  final bool visibleUserAgreement;
  final bool access;
  final bool multiCompanyMode;
  bool isOffline;

  Config.fromJson(Map<String, dynamic> json)
      : users = UsersConfig.fromJson(json['config']['users']),
        articles = ArticlesConfig.fromJson(json['config']['articles']),
        supportPhone = json['config']['support_phone'],
        supportEmail = json['config']['support_email'],
        visibleUserAgreement = json['config']['visible_user_agreement'],
        access = json['access'],
        multiCompanyMode = json['config']['multi_company_mode'],
        isOffline = json['is_offline'];
}

class UsersConfig {
  final bool registrable;

  UsersConfig.fromJson(Map<String, dynamic> json)
      : registrable = json['registrable'];
}

class ArticlesConfig {
  final bool registrable;

  ArticlesConfig.fromJson(Map<String, dynamic> json)
      : registrable = json['registrable'];
}
