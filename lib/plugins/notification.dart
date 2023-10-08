import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationPlugin {
  final FlutterLocalNotificationsPlugin np = FlutterLocalNotificationsPlugin();

  init() async {
    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {},
    );

    var initSettings = InitializationSettings(android: android, iOS: ios);

    await np.initialize(initSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    return np.show(id, title, body, await notificatinoDetails());
  }

  Future showScheduledNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payload,
      required DateTime scheduledDate}) async {
    return np.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        await notificatinoDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future showPeriodicNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payload,
      required RepeatInterval interval}) async {
    return np.periodicallyShow(
      id,
      title,
      body,
      interval,
      await notificatinoDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  notificatinoDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName',
          importance: Importance.max),
      iOS: DarwinNotificationDetails(),
    );
  }
}
