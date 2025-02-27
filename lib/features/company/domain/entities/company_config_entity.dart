class CompanyConfigEntity {
  final bool canCreateArticles;
  final String? phone;
  final String? email;

  CompanyConfigEntity(
      {required this.canCreateArticles,
      required this.phone,
      required this.email});
}
