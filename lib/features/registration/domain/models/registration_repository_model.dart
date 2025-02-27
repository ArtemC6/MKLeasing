/// SignUpResponse
abstract class SignUpResponse {}

class SuccessSignUpBeginResponse extends SignUpResponse {
  final String status;

  SuccessSignUpBeginResponse(this.status);
}

class SuccessSignUpFinishResponse extends SignUpResponse {
  final bool awaitingValidation;

  SuccessSignUpFinishResponse(this.awaitingValidation);
}

class ValidationFailedSignUpResponse extends SignUpResponse {
  Map errors = Map<String, List<String>>();
}
class RegistrationDisabledSignUpResponse extends SignUpResponse {
  String error = '';
}

