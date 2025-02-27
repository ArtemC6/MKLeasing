import 'package:drift/drift.dart';
import 'package:leasing_company/features/company/domain/entities/company_config_entity.dart';
import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/features/company/domain/repositories/company_repository.dart';
import 'package:leasing_company/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompanyRepositoryImpl extends CompanyRepository {
  final SharedPreferences shrdPrfc = getIt<SharedPreferences>();

  static const String CURRENT_COMPANY_REMOTE_ID_KEY = 'currentCompanyRemoteId';

  @override
  Future<void> set(CompanyEntity company) async {
    await (await SharedPreferences.getInstance()).setString(CURRENT_COMPANY_REMOTE_ID_KEY, company.uuid);
    controller.add(company);
  }

  @override
  Future<CompanyEntity?> getCurrent() async {
    CompanyEntity? company;

    String? currentCompanyUuid;
    try {
      currentCompanyUuid = (await SharedPreferences.getInstance()).getString(CURRENT_COMPANY_REMOTE_ID_KEY);
    } catch (exception, stackTrace) {
      print(exception);
      print(stackTrace);
    }

    // если компания не была выбрана ранее
    if (currentCompanyUuid == null) {
      // пытаемся взять первую попавшуюся
      var firstCompany = await this.getFirst();
      if (firstCompany == null) {
        return null;
      }
      currentCompanyUuid = firstCompany.uuid;
      await this.set(firstCompany);
    }

    company = await this.getByUuid(currentCompanyUuid);

    // если выбранная компания не существует
    if (company == null) {
      var firstCompany = await this.getFirst();
      if (firstCompany == null) {
        return null;
      }
      currentCompanyUuid = firstCompany.uuid;

      company = await this.getByUuid(currentCompanyUuid);

      if (company != null) {
        await this.set(company);
      }
    }

    return company;
  }

  Future<List<CompanyEntity>> getList() async {
    var companies = await database.select(database.companies).get();
    return companies
        .map(
          (company) => CompanyEntity(
            uuid: company.remoteUuid,
            name: company.name,
            config: CompanyConfigEntity(phone: company.phone, email: company.email, canCreateArticles: company.canCreateArticles),
          ),
        )
        .toList();
  }

  Future<CompanyEntity?> getFirst() async {
    var company = await (database.select(database.companies)
          ..orderBy([(t) => OrderingTerm(expression: t.id, mode: OrderingMode.asc)])
          ..limit(1))
        .getSingleOrNull();

    if (company == null) return null;

    return CompanyEntity(
        uuid: company.remoteUuid,
        name: company.name,
        config: CompanyConfigEntity(phone: company.phone, email: company.email, canCreateArticles: company.canCreateArticles));
  }

  Future<CompanyEntity?> getByUuid(String uuid) async {
    var company = await (database.select(database.companies)..where((tbl) => tbl.remoteUuid.equals(uuid))).getSingleOrNull();
    if (company == null) return null;

    return CompanyEntity(
        uuid: company.remoteUuid,
        name: company.name,
        config: CompanyConfigEntity(phone: company.phone, email: company.email, canCreateArticles: company.canCreateArticles));
  }
}
