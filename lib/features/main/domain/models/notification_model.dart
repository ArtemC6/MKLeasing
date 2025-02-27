import 'package:hive/hive.dart';
import 'package:leasing_company/features/main/domain/models/notification_status_model.dart';
part 'notification_model.g.dart';

@HiveType(typeId: 0)
class NotificationModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final NotificationStatusModel status;
  @HiveField(4)
  final int? createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
  });

  NotificationModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        status = NotificationStatusModel.fromJson(json['status']),
        createdAt = json['created_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'status': status.toJson(),
        'createdAt': createdAt,
      };
}
