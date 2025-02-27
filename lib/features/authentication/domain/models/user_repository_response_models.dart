import 'package:leasing_company/features/authentication/domain/models/user_model.dart';

/// LoginResponse
abstract class LoginResponse {}

class SuccessLoginResponse extends LoginResponse {
  final String token;
  final User user;

  SuccessLoginResponse(this.token, this.user);
}

class ValidationFailedLoginResponse extends LoginResponse {
  Map errors = Map<String, List<String>>();
}

/// MeResponse
abstract class MeResponse {}

class SuccessMeResponse extends MeResponse {
  final User user;

  SuccessMeResponse(this.user);
}

class FailureMeResponse extends MeResponse {}

/// RecoverySmsResponse
abstract class RecoverySmsResponse {}

class SuccessRecoverySmsResponse extends RecoverySmsResponse {}

class ValidationFailedRecoverySmsResponse extends RecoverySmsResponse {
  Map errors = Map<String, List<String>>();
}