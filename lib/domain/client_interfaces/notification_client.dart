import 'package:todo/domain/entities/notification/notification_message.dart';

abstract class NotificationClient {
  Future<void> addNotification(NotificationMessage message);

  Future<void> deleteNotification(int notificationId);

  Future<void> updateNotification(NotificationMessage message);
}
