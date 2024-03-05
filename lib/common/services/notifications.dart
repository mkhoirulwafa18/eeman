// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// ignore_for_file: depend_on_referenced_packages, lines_longer_than_80_chars

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final timeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  /// Initialize notification
  Future<void> initializeNotification() async {
    await configureLocalTimeZone();
    const initializationSettingsDarwin = DarwinInitializationSettings(
        // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
        );

    const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initializationSettings = InitializationSettings(
      iOS: initializationSettingsDarwin,
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Future<void> onDidReceiveLocalNotification(
  //   int id,
  //   String title,
  //   String body,
  //   String payload,
  // ) async {
  //   // display a dialog with the notification details, tap ok to go to another page
  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) => CupertinoAlertDialog(
  //       title: Text(title),
  //       content: Text(body),
  //       actions: [
  //         CupertinoDialogAction(
  //           isDefaultAction: true,
  //           child: const Text('Ok'),
  //           onPressed: () async {
  //             Navigator.of(context, rootNavigator: true).pop();
  //             await Navigator.push(
  //               context,
  //               MaterialPageRoute<dynamic>(
  //                 builder: (context) => const TasbihPage(),
  //               ),
  //             );
  //           },
  //         )
  //       ],
  //     ),
  //   );

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
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  ///Show Notification
  Future<void> showNotification({
    required String title,
    required String sound,
  }) async {
    await flutterLocalNotificationsPlugin.show(
      123,
      'Waktu $title telah tiba!',
      'Sudah waktunya untuk $title',
      NotificationDetails(
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
          actions: const [AndroidNotificationAction('kajfw', 'Stop')],
        ),
        iOS: DarwinNotificationDetails(sound: '$sound.mp3'),
      ),
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
      NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id $sound',
          'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound(sound),
        ),
        iOS: DarwinNotificationDetails(sound: '$sound.mp3'),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
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
