import 'dart:convert';

import 'package:leasing_company/api/RejectDelegateService.dart';
import 'package:leasing_company/features/make_report/domain/models/reject_delegate_response_models.dart';
import 'package:leasing_company/features/make_report/domain/repositories/reject_delegate_repository.dart';

class RejectDelegateRepositoryImpl implements RejectDelegateRepository {
  final RejectDelegateService rejectDelegateService;

  RejectDelegateRepositoryImpl(this.rejectDelegateService);

  Future<RejectResponse> reject(
      {required String companyUuid,
        required int reviewTemplateId,
      required String reason,
      required String newUserPhone,
      required String newUserName,
      required String newUserCompanyName,
      required String newUserPosition}) async {
    final response = await rejectDelegateService.reject(companyUuid, reviewTemplateId,
        reason, newUserPhone, newUserName, newUserCompanyName, newUserPosition);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return SuccessRejectResponse(json['status']);
    }
    if (response.statusCode == 422) {
      final json = jsonDecode(response.body);
      ValidationFailedRejectResponse validationFailedRejectResponse =
          ValidationFailedRejectResponse();
      validationFailedRejectResponse.errors = json['errors'];
      return validationFailedRejectResponse;
    }
    throw Exception();
  }

  Future<DelegateResponse> checkPhoneForDelegate(
      {required String companyUuid, required int reviewTemplateId, required String phone}) async {
    final response = await rejectDelegateService.checkPhoneForDelegate(companyUuid,
        reviewTemplateId, phone);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return SuccessCheckPhoneForDelegateResponse(exists: json['exists'], allowedCreate: json['allowed_create']);
    }
    if (response.statusCode == 422) {
      final json = jsonDecode(response.body);
      ValidationFailedDelegateResponse validationFailedDelegateResponse =
          ValidationFailedDelegateResponse();
      validationFailedDelegateResponse.errors = json['errors'];
      return validationFailedDelegateResponse;
    }
    throw Exception();
  }

  Future<DelegateResponse> delegate(
      {required String companyUuid,required int reviewTemplateId,
      required String reason,
      required String phone,
      required String email,
      required String firstname,
      required String lastname,
      required String companyName,
      required String position}) async {
    final response = await rejectDelegateService.delegate(companyUuid,reviewTemplateId,
        reason, phone, email, firstname, lastname, companyName, position);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return SuccessDelegateResponse();
    }
    if (response.statusCode == 422) {
      final json = jsonDecode(response.body);
      ValidationFailedDelegateResponse validationFailedDelegateResponse =
          ValidationFailedDelegateResponse();
      validationFailedDelegateResponse.errors = json['errors'];
      return validationFailedDelegateResponse;
    }
    throw Exception();
  }
}
