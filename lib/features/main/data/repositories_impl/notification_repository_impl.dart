import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:leasing_company/api/services.dart';
import 'package:leasing_company/features/main/domain/models/notification_model.dart';
import 'package:leasing_company/features/main/domain/repositories/notification_repository.dart';
import 'package:leasing_company/features/main/presentation/enums/notification_status.dart';
import 'package:leasing_company/main.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationService notificationService;
  Box? appBox;

  NotificationRepositoryImpl(this.notificationService);

  Future<List<NotificationModel>> getList() async {
    appBox = getIt.get(instanceName: 'AppBox');
    try {
      final response = await notificationService.getIndex();
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        List<NotificationModel> notifications = json['data']
            .map<NotificationModel>((item) => NotificationModel.fromJson(item))
            .toList();
        notifications.addAll(List<NotificationModel>.from(
            appBox?.get('localNotifications') ?? []));
        notifications.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        return notifications.reversed.toList();
      } else {
        List<NotificationModel> notifications =
        (List<NotificationModel>.from(appBox?.get('localNotifications') ?? []));
        notifications.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        return notifications.reversed.toList();
      }
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
    List<NotificationModel> notifications =
    (List<NotificationModel>.from(appBox?.get('localNotifications') ?? []));
    notifications.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
    return notifications.reversed.toList();
  }

  @override
  Future<void> saveLocalList(
      {required LocalNotificationStatus? notificationStatus,
      required String reviewOrTaskTitle,
      required bool isReview,
      required String objectTitle}) async {
    NotificationModel notification = NotificationStatusExt.modelByLocalStatus(
        notificationStatus: notificationStatus,
        reviewOrTaskTitle: reviewOrTaskTitle,
        isReview: isReview,
        objectTitle: objectTitle);
    appBox = getIt.get(instanceName: 'AppBox');
    List<NotificationModel>? notifications =
        (List<NotificationModel>.from(appBox?.get('localNotifications') ?? []));
    if (notifications.length < 100) {
      notifications.add(notification);
    } else {
      notifications.removeLast();
      notifications.add(notification);
    }
    appBox?.put('localNotifications', notifications);
  }
}
