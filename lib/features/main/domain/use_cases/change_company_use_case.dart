import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/features/company/domain/repositories/company_repository.dart';

class ChangeCompanyUseCase {
  final CompanyRepository _repository;

  ChangeCompanyUseCase(this._repository);

  Future<void> call(CompanyEntity company) => _repository.set(company);
}
