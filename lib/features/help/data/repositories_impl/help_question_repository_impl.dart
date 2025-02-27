import 'package:leasing_company/core/drift/drift.dart';
import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/features/help/domain/repositories/help_question_repository.dart';
import 'package:leasing_company/main.dart';

class HelpQuestionRepositoryImpl implements HelpQuestionRepository {
  Future<List<HelpQuestion>> getList(CompanyEntity company) async {
    return (database.select(database.helpQuestions)
          ..where((tbl) => tbl.companyUuid.equals(company.uuid)))
        .get();
  }
}
