import 'package:leasing_company/features/make_report/domain/models/reject_delegate_response_models.dart';

abstract class RejectDelegateRepository {
  Future<RejectResponse> reject(
      {required String companyUuid,
      required int reviewTemplateId,
      required String reason,
      required String newUserPhone,
      required String newUserName,
      required String newUserCompanyName,
      required String newUserPosition});

  Future<DelegateResponse> checkPhoneForDelegate(
      {required String companyUuid,
      required int reviewTemplateId,
      required String phone});

  Future<DelegateResponse> delegate(
      {required String companyUuid,
      required int reviewTemplateId,
      required String reason,
      required String phone,
      required String email,
      required String firstname,
      required String lastname,
      required String companyName,
      required String position});
}
