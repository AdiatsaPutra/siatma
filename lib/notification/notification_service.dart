import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:si_atma/models/user_pill_request.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:si_atma/constants/routes.dart';

import '../models/user.dart';

class NotificationService {
  String name = 'birds';

  static NotificationService? instance;

  NotificationService._internal(String name);

  factory NotificationService(String name) {
    var inst = NotificationService._internal(name);
    instance = inst;
    return inst;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future selectNotification(BuildContext context, String payload) async {
    await Navigator.pushReplacementNamed(context, mainPage);
  }

  NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: AndroidNotificationDetails(
      'channel ID',
      'channel name',
      playSound: true,
      priority: Priority.high,
      importance: Importance.high,
      sound: RawResourceAndroidNotificationSound('birds.mp3'),
      enableVibration: false,
    ),
  );

  Future<void> scheduleNotifications(
    User user,
    UserPillRequest userPill,
    int duration,
  ) async {
    try {
      for (var i = 0; i < userPill.timeLasting; i++) {
        final timezone = tz.getLocation('Asia/Jakarta');
        await flutterLocalNotificationsPlugin.zonedSchedule(
            Random().nextInt(999999),
            "Hai ${user.name}",
            "Ayo minum pil ${userPill.name} dan ceklis pilmu",
            tz.TZDateTime.from(userPill.time, timezone)
                .add(Duration(days: i, hours: duration)),
            platformChannelSpecifics,
            androidAllowWhileIdle: true,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime);
      }
    } catch (e) {
      Logger().i(e);
    }
  }

  Future<void> clearNotification() async {
    try {
      await flutterLocalNotificationsPlugin.cancelAll();
    } catch (e) {
      Logger().i(e);
    }
  }
}
// class NotificationService {

//   late String notification;

//   static final NotificationService _notificationService =
//       NotificationService._internal();

//   factory NotificationService({String notification = ''}) {
//     _notificationService.notification = notification;
//     return _notificationService;
//   }

//   

//   
// }
