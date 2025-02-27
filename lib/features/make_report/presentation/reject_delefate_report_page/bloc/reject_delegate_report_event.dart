part of 'reject_delegate_report_bloc.dart';

abstract class RejectDelegateReportEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RejectPressedEvent extends RejectDelegateReportEvent {
  final String companyUuid;
  final int reviewTemplateId;
  final String reason;
  final String newUserPhone;
  final String newUserName;
  final String newUserCompanyName;
  final String newUserPosition;
  final String reviewOrTaskTitle;
  final String objectTitle;

  RejectPressedEvent({
    required this.companyUuid,
    required this.reviewTemplateId,
    required this.reason,
    required this.newUserPhone,
    required this.newUserName,
    required this.newUserCompanyName,
    required this.newUserPosition,
    required this.reviewOrTaskTitle,
    required this.objectTitle,
  });
}

class CheckPhoneForDelegatePressedEvent extends RejectDelegateReportEvent {
  final String companyUuid;
  final int reviewTemplateId;
  final String phone;

  CheckPhoneForDelegatePressedEvent(
      {required this.companyUuid,
      required this.reviewTemplateId,
      required this.phone});
}

class DelegatePressedEvent extends RejectDelegateReportEvent {
  final String companyUuid;
  final int reviewTemplateId;
  final String reason;
  final String phone;
  final String email;
  final String firstname;
  final String lastname;
  final String companyName;
  final String position;
  final String reviewOrTaskTitle;
  final String objectTitle;

  DelegatePressedEvent({
    required this.companyUuid,
    required this.reviewTemplateId,
    required this.reason,
    required this.phone,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.companyName,
    required this.position,
    required this.reviewOrTaskTitle,
    required this.objectTitle,
  });
}
