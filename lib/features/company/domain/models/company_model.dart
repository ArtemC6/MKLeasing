import 'package:leasing_company/features/company/domain/entities/company_entity.dart';
import 'package:leasing_company/features/company/domain/models/company_config_model.dart';

class CompanyModel extends CompanyEntity {
  CompanyModel(
      {required String uuid,
      required String name,
      required CompanyConfigModel config})
      : super(uuid: uuid, name: name, config: config);

  factory CompanyModel.fromJson(dynamic json) => CompanyModel(
      uuid: json['uuid'],
      name: json['name'],
      config: CompanyConfigModel.fromJson(json['config']));

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'name': name,
        'config': (config as CompanyConfigModel).toJson()
      };
}
