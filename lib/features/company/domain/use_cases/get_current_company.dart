import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/features/company/domain/repositories/company_repository.dart';

class GetCurrentCompany {
  final CompanyRepository companyRepository;

  GetCurrentCompany(this.companyRepository);

  Future<CompanyEntity?> call() async {
    return await companyRepository.getCurrent();
  }
}
