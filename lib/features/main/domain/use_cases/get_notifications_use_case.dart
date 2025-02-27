import 'package:leasing_company/features/main/domain/models/notification_model.dart';
import 'package:leasing_company/features/main/domain/repositories/notification_repository.dart';

class GetNotificationsUseCase {
  final NotificationRepository _repository;

  GetNotificationsUseCase(this._repository);

  Future<List<NotificationModel>> call() => _repository.getList();
}
