import 'dart:async';

import 'package:leasing_company/features/company/domain/entities/company_entity.dart';

abstract class CompanyRepository {
  final controller = StreamController<CompanyEntity>.broadcast();

  CompanyRepository() {
    getCurrent().then((value) {
      if (value != null) {
        controller.add(value);
      }
    });
  }

  Future<void> set(CompanyEntity company);

  Future<CompanyEntity?> getCurrent();

  Future<CompanyEntity?> getFirst();

  Future<CompanyEntity?> getByUuid(String uuid);

  Future<List<CompanyEntity>> getList();
}
