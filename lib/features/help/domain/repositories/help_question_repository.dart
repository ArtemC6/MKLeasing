import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/company/domain/entities/company_entity.dart';

abstract class HelpQuestionRepository {
  Future<List<HelpQuestion>> getList(CompanyEntity company);
}
