// ignore_for_file: depend_on_referenced_packages, lines_longer_than_80_chars

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  NotificationHelper() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _initialize();
  }

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future<void> _initialize() async {
    // Configure Timezone
    tz.initializeTimeZones();
    final timeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));

    // Initialize Notification
    const initializationSettingsDarwin = DarwinInitializationSettings();
    const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initializationSettings = InitializationSettings(
      iOS: initializationSettingsDarwin,
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  /// Set right date and time for notifications
  tz.TZDateTime convertTime(int hour, int minutes) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );

    // If the scheduled time has already passed for the current day,
    // it adds one day to ensure the notification is shown on the following day.
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  // get Notification Details
  NotificationDetails getDetails(String sound, String title) => NotificationDetails(
        android: AndroidNotificationDetails(
          'reminder',
          'adzan notification',
          channelDescription: 'this notification is for adzan notification on prayer time page',
          importance: Importance.max,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound(sound),
          autoCancel: false,
          enableLights: true,
          visibility: NotificationVisibility.public,
          actions: [AndroidNotificationAction(title, 'Okay')],
        ),
        iOS: DarwinNotificationDetails(sound: '$sound.mp3'),
      );

  ///Show Notification
  Future<void> showNotification({
    required String title,
    required String sound,
  }) async {
    await flutterLocalNotificationsPlugin.show(
      123,
      'Waktu $title telah tiba!',
      'Sudah waktunya untuk $title',
      getDetails(sound, title),
      payload: 'alarmAdzan',
    );
  }

  /// Scheduled Notification
  Future<void> scheduledNotification({
    required int hour,
    required int minutes,
    required int id,
    required String title,
    required String sound,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'Waktu $title telah tiba!',
      'Sudah waktunya untuk $title',
      convertTime(hour, minutes),
      getDetails(sound, title),
      // androidAllowWhileIdle: true,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
      payload: 'It could be anything you pass',
    );
  }

  /// Request IOS permissions
  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> cancelAll() async => flutterLocalNotificationsPlugin.cancelAll();
  Future<void> cancel(int id) async => flutterLocalNotificationsPlugin.cancel(id);
}
