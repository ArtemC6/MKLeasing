part of 'reject_delegate_report_bloc.dart';

abstract class RejectDelegateReportState extends Equatable {
  const RejectDelegateReportState();

  @override
  List<Object> get props => [];
}

class RejectDelegateReadyState extends RejectDelegateReportState {}

class RejectInProgressState extends RejectDelegateReportState {}

class RejectSuccessState extends RejectDelegateReportState {}

class CheckPhoneForDelegationProgressState extends RejectDelegateReportState {}

class CheckPhoneForDelegationSuccessState extends RejectDelegateReportState {
  final bool exists;
  final bool allowedCreate;

  CheckPhoneForDelegationSuccessState(
      {required this.exists, required this.allowedCreate});
}

class DelegateInProgressState extends RejectDelegateReportState {}

class DelegateSuccessState extends RejectDelegateReportState {}

class RejectDelegateValidationFailureState extends RejectDelegateReportState {
  final Map errors;

  RejectDelegateValidationFailureState(this.errors);
}

class RejectDelegateErrorState extends RejectDelegateReportState {}
