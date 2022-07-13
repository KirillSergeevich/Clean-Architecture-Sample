import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todo/domain/client_interfaces/notification_client.dart';
import 'package:todo/domain/entities/notification/notification_message.dart';

class NotificationClientImpl implements NotificationClient {
  static final _notifications = FlutterLocalNotificationsPlugin();

  @override
  Future<void> addNotification(NotificationMessage message) async {
    final reminderDate = DateTime.parse(message.reminderDate);
    return _notifications.zonedSchedule(
      message.id,
      message.title,
      message.description,
      tz.TZDateTime.from(reminderDate, tz.local),
      _notificationDetails(),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  static Future<void> initNotifications() async {
    tz.initializeTimeZones();
    final android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = const IOSInitializationSettings();
    final settings = InitializationSettings(android: android, iOS: iOS);
    await _notifications.initialize(settings);
  }

  NotificationDetails _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'id',
        'name',
        'description',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  @override
  Future<void> deleteNotification(int notificationId) async {
    await _notifications.cancel(notificationId);
  }

  @override
  Future<void> updateNotification(NotificationMessage message) async {
    await _notifications.cancel(message.id);
    await addNotification(message);
  }
}
