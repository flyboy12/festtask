import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final NotificationApi _notificationApi = NotificationApi._internal();

  static final _notifications = FlutterLocalNotificationsPlugin();
  factory NotificationApi() {
    return _notificationApi;
  }
  NotificationApi._internal();

  Future<void> init({bool initScheduled = false}) async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, iOS: null, macOS: null);
    await _notifications.initialize(
      initializationSettings,
    );
    tz.initializeTimeZones();
  }

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        'channel description',
        importance: Importance.max,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static void showScheduledNotification({
    int id,
    String title,
    String body,
    String payload,
    DateTime scheduledDate,
  }) async =>
      _notifications.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(scheduledDate, tz.local),
          await _notificationDetails(),
          payload: payload,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
  static Future showNotification({
    int id = 0,
    String title,
    String body,
    String payload,
  }) async =>
      _notifications.show(id, title, body, await _notificationDetails(),
          payload: payload);
  void cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  void cancelAllNotification() async {
    await _notifications.cancelAll();
  }
}
