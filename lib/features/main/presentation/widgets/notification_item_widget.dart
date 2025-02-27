import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leasing_company/features/main/domain/models/notification_model.dart';
import 'package:leasing_company/features/main/presentation/enums/notification_status.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  late final NotificationStatus _notificationStatus;

  NotificationItem(this.notification, {Key? key}) : super(key: key) {
    _notificationStatus =
        NotificationStatusExt.statusByModel(notification.status);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFC6D2CB1A).withOpacity(0.1)),
        boxShadow: [BoxShadow(
          offset:Offset(0, 1.0),
          spreadRadius: 0.1,
          blurRadius: 1.8,
          color: Colors.black.withOpacity(0.14),
        )],
      ),
      child: Row(
        children: [
          Icon(_notificationStatus.icon(), color: _notificationStatus.color()),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  notification.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13),
                ),
                SizedBox(height: 2),
                Text(
                  DateFormat('dd.MM.yyyy HH:mm:ss').format(
                    DateTime.fromMillisecondsSinceEpoch(
                            notification.createdAt! * 1000)
                        .toLocal(),
                  ),
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
