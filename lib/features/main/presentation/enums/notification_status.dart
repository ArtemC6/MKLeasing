import 'package:flutter/material.dart';
import 'package:leasing_company/features/main/domain/models/notification_model.dart';
import 'package:leasing_company/features/main/domain/models/notification_status_model.dart';
import 'package:leasing_company/generated/l10n.dart';

enum NotificationStatus {
  created,
  needReport,
  uploading,
  uploadFailed,
  waitChecking,
  reportDenied,
  reportConfirmed,
  gotToWork,
  reportCreating,
  reportSending,
  reviewRequestReject,
  reportCreatedByUser,
  reportDeletedByUser,
  reportRework,
  articleCreatedByTheUser,
  reviewRequestDelegate,
  reviewRequestDelete,
  taskCreated,
  taskDeleted,
  taskRejected
}

enum LocalNotificationStatus {
  gotToWork,
  reportSending,
  reportDeletedByUser,
  reportCreatedByUser
}

extension NotificationStatusExt on NotificationStatus {
  Color color() {
    switch (this) {
      case NotificationStatus.created:
        return Color(0xff4AAF57);
      case NotificationStatus.needReport:
        return Color(0xff757575);
      case NotificationStatus.uploading:
        return Color(0xff246BFD);
      case NotificationStatus.uploadFailed:
        return Color(0xffF75555);
      case NotificationStatus.waitChecking:
        return Color(0xFF673AB3);
      case NotificationStatus.reportDenied:
        return Color(0xffF75555);
      case NotificationStatus.reportConfirmed:
        return Color(0xff4AAF57);
      case NotificationStatus.gotToWork:
        return Color(0xff757575);
      case NotificationStatus.reportCreating:
        return Color(0xff246BFD);
      case NotificationStatus.reportSending:
        return Color(0xff246BFD);
      case NotificationStatus.reviewRequestReject:
        return Color(0xffF75555);
      case NotificationStatus.reportCreatedByUser:
        return Color(0xff757575);
      case NotificationStatus.reportDeletedByUser:
        return Color(0xffF75555);
      case NotificationStatus.reportRework:
        return Color(0xFFFF981F);
      case NotificationStatus.articleCreatedByTheUser:
        return Color(0xff757575);
      case NotificationStatus.reviewRequestDelegate:
        return Color(0xff757575);
      case NotificationStatus.reviewRequestDelete:
        return Color(0xffF75555);
      case NotificationStatus.taskCreated:
        return Color(0xff757575);
      case NotificationStatus.taskDeleted:
        return Color(0xffF75555);
      case NotificationStatus.taskRejected:
        return Color(0xffF75555);
    }
  }

  IconData icon() {
    switch (this) {
      case NotificationStatus.created:
        return Icons.error_outline;
      case NotificationStatus.needReport:
        return Icons.error_outline;
      case NotificationStatus.uploading:
        return Icons.error_outline;
      case NotificationStatus.uploadFailed:
        return Icons.error_outline;
      case NotificationStatus.waitChecking:
        return Icons.error_outline;
      case NotificationStatus.reportDenied:
        return Icons.cancel_outlined;
      case NotificationStatus.reportConfirmed:
        return Icons.error_outline;
      case NotificationStatus.gotToWork:
        return Icons.error_outline;
      case NotificationStatus.reportCreating:
        return Icons.error_outline;
      case NotificationStatus.reportSending:
        return Icons.error_outline;
      case NotificationStatus.reviewRequestReject:
        return Icons.error_outline;
      case NotificationStatus.reportCreatedByUser:
        return Icons.error_outline;
      case NotificationStatus.reportDeletedByUser:
        return Icons.error_outline;
      case NotificationStatus.reportRework:
        return Icons.error_outline;
      case NotificationStatus.articleCreatedByTheUser:
        return Icons.error_outline;
      case NotificationStatus.reviewRequestDelegate:
        return Icons.error_outline;
      case NotificationStatus.reviewRequestDelete:
        return Icons.error_outline;
      case NotificationStatus.taskCreated:
        return Icons.error_outline;
      case NotificationStatus.taskDeleted:
        return Icons.error_outline;
      case NotificationStatus.taskRejected:
        return Icons.error_outline;
    }
  }

  static NotificationStatus statusByModel(
      NotificationStatusModel notificationModel) {
    switch (notificationModel.keyword) {
      case 'created':
        return NotificationStatus.created;
      case 'need_report':
        return NotificationStatus.needReport;
      case 'uploading':
        return NotificationStatus.uploading;
      case 'upload_failed':
        return NotificationStatus.uploadFailed;
      case 'wait_checking':
        return NotificationStatus.waitChecking;
      case 'report_denied':
        return NotificationStatus.reportDenied;
      case 'report_confirmed':
        return NotificationStatus.reportConfirmed;
      case 'got_to_work':
        return NotificationStatus.gotToWork;
      case 'report_creating':
        return NotificationStatus.reportCreating;
      case 'report_sending':
        return NotificationStatus.reportSending;
      case 'review_request_reject':
        return NotificationStatus.reviewRequestReject;
      case 'report_created_by_user':
        return NotificationStatus.reportCreatedByUser;
      case 'report_deleted_by_user':
        return NotificationStatus.reportDeletedByUser;
      case 'report_rework':
        return NotificationStatus.reportRework;
      case 'article_created_by_the_user':
        return NotificationStatus.articleCreatedByTheUser;
      case 'review_request_delegate':
        return NotificationStatus.reviewRequestDelegate;
      case 'review_request_delete':
        return NotificationStatus.reviewRequestDelete;
      case 'task_created':
        return NotificationStatus.taskCreated;
      case 'task_deleted':
        return NotificationStatus.taskDeleted;
      case 'task_rejected':
        return NotificationStatus.taskRejected;
      default:
        return NotificationStatus.waitChecking;
    }
  }

  static NotificationModel modelByLocalStatus(
      {required LocalNotificationStatus? notificationStatus,
      required String reviewOrTaskTitle,
      required bool isReview,
      required String objectTitle}) {
    switch (notificationStatus) {
      case LocalNotificationStatus.gotToWork:
        return NotificationModel(
            id: 0,
            title:
                '${S().gotToWork}\n${isReview ? S().review : S().task} «$reviewOrTaskTitle»',
            description: '$objectTitle',
            status: NotificationStatusModel(
                id: 0, name: S().gotToWork, keyword: 'got_to_work'),
            createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000);

      case LocalNotificationStatus.reportSending:
        return NotificationModel(
            id: 0,
            title:
                '${S().sending}\n${isReview ? S().review : S().task} «$reviewOrTaskTitle»',
            description: '$objectTitle',
            status: NotificationStatusModel(
                id: 0, name: S().sending, keyword: 'report_sending'),
            createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000);

      case LocalNotificationStatus.reportDeletedByUser:
        return NotificationModel(
            id: 0,
            title:
                '${S().deleted}\n${isReview ? S().review : S().task} «$reviewOrTaskTitle»',
            description: '$objectTitle',
            status: NotificationStatusModel(
                id: 0, name: S().deleted, keyword: 'report_deleted_by_user'),
            createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000);
      case LocalNotificationStatus.reportCreatedByUser:
        return NotificationModel(
            id: 0,
            title:
                '${S().created}\n${isReview ? S().review : S().task} «$reviewOrTaskTitle»',
            description: '$objectTitle',
            status: NotificationStatusModel(
                id: 0, name: S().created, keyword: 'report_created_by_user'),
            createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000);
      default:
        return NotificationModel(
            id: 0,
            title: 'title',
            description: 'description',
            status: NotificationStatusModel(id: 0, name: '', keyword: ''),
            createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000);
    }
  }
}
