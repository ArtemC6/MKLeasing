import 'package:hive/hive.dart';

part 'notification_status_model.g.dart';
@HiveType(typeId: 1)
class NotificationStatusModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String keyword;

  NotificationStatusModel(
      {required this.id, required this.name, required this.keyword});

  NotificationStatusModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        keyword = json['keyword'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'keyword': keyword,
      };
}
