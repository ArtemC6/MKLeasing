import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/features/company/domain/repositories/company_repository.dart';

class GetCompaniesUseCase {
  final CompanyRepository _repository;

  GetCompaniesUseCase(this._repository);

  Future<List<CompanyEntity>> call() => _repository.getList();
}
