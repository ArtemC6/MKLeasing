import 'package:leasing_company/features/registration/domain/models/registration_repository_model.dart';

abstract class SignUpRepository {
  Future<SignUpResponse> signUpBegin(int? tenantId);

  Future signUpFinish(
      {required int tenantId,
      required String firstname,
      required String lastname,
      required String patronymic,
      required String company,
      required String inn,
      required String position,
      required String phone,
      required String email});
}
