import 'package:equatable/equatable.dart';
import 'package:leasing_company/features/company/domain/entities/company_config_entity.dart';

class CompanyEntity extends Equatable {
  final String uuid;
  final String name;
  final CompanyConfigEntity config;
  //suda

  CompanyEntity({required this.uuid, required this.name, required this.config});

  @override
  List<Object?> get props => [uuid];
}
