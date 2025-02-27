import 'package:leasing_company/features/main/domain/models/notification_model.dart';
import 'package:leasing_company/features/main/presentation/enums/notification_status.dart';

abstract class NotificationRepository {
  Future<List<NotificationModel>> getList();

  Future<void> saveLocalList(
      {required LocalNotificationStatus? notificationStatus,
      required String reviewOrTaskTitle,
      required bool isReview,
      required String objectTitle});
}
