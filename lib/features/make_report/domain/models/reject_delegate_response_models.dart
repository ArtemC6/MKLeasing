/// RejectResponse
abstract class RejectResponse {}

class SuccessRejectResponse extends RejectResponse {
  final String status;
  SuccessRejectResponse(this.status);
}

class ValidationFailedRejectResponse extends RejectResponse {
  Map errors = Map<String, List<String>>();
}

/// DelegateResponse
abstract class DelegateResponse {}

class SuccessCheckPhoneForDelegateResponse extends DelegateResponse {
 final bool exists;
 final bool allowedCreate;
 SuccessCheckPhoneForDelegateResponse({required this.exists,required this.allowedCreate});
}

class SuccessDelegateResponse extends DelegateResponse {
  SuccessDelegateResponse();
}

class ValidationFailedDelegateResponse extends DelegateResponse {
  Map errors = Map<String, List<String>>();
}
