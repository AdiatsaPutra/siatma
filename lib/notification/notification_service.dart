import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:si_atma/models/user_pill_request.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:si_atma/constants/routes.dart';

import '../models/user.dart';

class NotificationService {
  bool played = true;
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

  NotificationDetails platformChannelSpecifics = const NotificationDetails(
    android: AndroidNotificationDetails(
      'channel ID',
      'channel name',
      playSound: true,
      priority: Priority.high,
      importance: Importance.high,
      // sound: RawResourceAndroidNotificationSound('birds'),
      enableVibration: true,
    ),
  );

  // The background
  static SendPort? uiSendPort;

  // The callback for our alarm
  static Future<void> callback() async {
    String countKey = 'count';

    String isolateName = 'isolate';
    // Get the previous cached count and increment it.
    final prefs = await SharedPreferences.getInstance();
    final currentCount = prefs.getInt(countKey) ?? 0;
    final newCount = currentCount + 1;
    await prefs.setInt(countKey, newCount);

    currentCount <= newCount
        ? FlutterRingtonePlayer.play(fromAsset: 'assets/birds.mp3')
        : FlutterRingtonePlayer.stop();

    ReceivePort receiver = ReceivePort();

    // This will be null if we're running in the background.
    uiSendPort ??= IsolateNameServer.lookupPortByName(isolateName);
    uiSendPort?.send('stop');
    receiver.listen((message) async {
      if (message == "stop") {
        await FlutterRingtonePlayer.stop();
      }
    });
  }

  Future<void> scheduleNotifications(
    User user,
    UserPillRequest userPill,
    int duration,
  ) async {
    try {
      for (var i = 0; i < userPill.timeLasting; i++) {
        final id = Random().nextInt(999999);
        final timezone = tz.getLocation('Asia/Jakarta');
        await AndroidAlarmManager.oneShotAt(
          userPill.time.add(Duration(hours: duration)),
          id,
          callback,
          allowWhileIdle: true,
          exact: true,
          wakeup: true,
        );
        await flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          "Hai ${user.name}",
          "Ayo minum pil ${userPill.name} dan ceklis pilmu",
          tz.TZDateTime.from(userPill.time, timezone)
              .add(Duration(days: i, hours: duration)),
          platformChannelSpecifics,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        );
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
