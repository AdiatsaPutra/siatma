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
  static final NotificationService _notificationService =
      NotificationService._internal();
  factory NotificationService() {
    return _notificationService;
  }
  NotificationService._internal();

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

  NotificationDetails platformChannelSpecifics = const NotificationDetails(
    android: AndroidNotificationDetails(
      'channel ID',
      'channel name',
      playSound: true,
      priority: Priority.high,
      importance: Importance.high,
    ),
  );

  Future<void> scheduleNotifications(
      User user, UserPillRequest userPill, int duration) async {
    try {
      for (var i = 0; i < userPill.timeLasting; i++) {
        final timezone = tz.getLocation('Asia/Jakarta');
        await flutterLocalNotificationsPlugin.zonedSchedule(
            Random().nextInt(999999),
            "Hi ${user.name}",
            "Lets take your ${userPill.name} medicine",
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
