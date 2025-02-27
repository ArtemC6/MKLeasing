import 'dart:convert';

import 'package:leasing_company/api/SignService.dart';
import 'package:leasing_company/features/registration/domain/models/registration_repository_model.dart';
import 'package:leasing_company/features/registration/domain/repositories/sign_up_repository.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final SignService signService;

  SignUpRepositoryImpl(this.signService);

  Future<SignUpResponse> signUpBegin(int? id) async {
    final response = await signService.signupBegin(id);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return SuccessSignUpBeginResponse(json['status']);
    }
    if (response.statusCode == 422) {
      final json = jsonDecode(response.body);
      var validationFailedSignUpResponse = ValidationFailedSignUpResponse();
      validationFailedSignUpResponse.errors = json['errors'];
      return validationFailedSignUpResponse;
    }
    if (response.statusCode == 403) {
      final json = jsonDecode(response.body);
      var validationFailedLoginResponse = RegistrationDisabledSignUpResponse();
      validationFailedLoginResponse.error = json['message'];
      return validationFailedLoginResponse;
    }

    throw Exception();
  }

  Future signUpFinish(
      {required int tenantId,
      required String firstname,
      required String lastname,
      required String patronymic,
      required String company,
      required String inn,
      required String position,
      required String phone,
      required String email}) async {
    final response = await signService.signupFinish(tenantId, firstname,
        lastname, patronymic, company, inn, position, phone, email);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return SuccessSignUpFinishResponse(json['awaiting_validation']);
    }
    if (response.statusCode == 422) {
      final json = jsonDecode(response.body);
      var validationFailedLoginResponse = ValidationFailedSignUpResponse();
      validationFailedLoginResponse.errors = json['errors'];
      return validationFailedLoginResponse;
    }
    if (response.statusCode == 403) {
      final json = jsonDecode(response.body);
      var validationFailedLoginResponse = RegistrationDisabledSignUpResponse();
      validationFailedLoginResponse.error = json['message'];
      return validationFailedLoginResponse;
    }
    throw Exception();
  }
}
