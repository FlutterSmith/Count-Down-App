import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/event.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();
    final androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final initSettings = InitializationSettings(android: androidSettings);
    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  Future<void> scheduleNotification(Event event) async {
    final scheduledDate =
        event.eventDate.subtract(Duration(days: event.notificationDaysBefore));
    if (scheduledDate.isAfter(DateTime.now())) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        event.id ?? 0,
        'Upcoming Event',
        '${event.title} is coming up!',
        tz.TZDateTime.from(scheduledDate, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'event_channel',
            'Event Notifications',
            channelDescription: 'Notifications for countdown events',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }
}
