import 'dart:ui';
import 'dart:isolate';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:si_atma/blocs/add_reminder/add_reminder_cubit.dart';
import 'package:si_atma/blocs/reminder/reminder_cubit.dart';
import 'package:si_atma/blocs/user/user_cubit.dart';
import 'package:si_atma/constants/constants.dart';
import 'package:si_atma/constants/routes.dart';

import 'notification/notification_service.dart';

void main() async {
  /// The [SharedPreferences] key to access the alarm fire count.
  const String countKey = 'count';

  /// The name associated with the UI isolate's [SendPort].
  const String isolateName = 'isolate';

  /// A port used to communicate from a background isolate to the UI isolate.
  final ReceivePort port = ReceivePort();

  /// Global [SharedPreferences] object.
  SharedPreferences? prefs;
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService('assets/birds.mp3').init();
  IsolateNameServer.registerPortWithName(
    port.sendPort,
    isolateName,
  );
  prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey(countKey)) {
    await prefs.setInt(countKey, 0);
  }

  await AndroidAlarmManager.initialize();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit()..profile(),
        ),
        BlocProvider(
          create: (context) => ReminderCubit()
            ..getPill(DateFormat('yyyy-MM-dd').format(DateTime.now())),
        ),
        BlocProvider(
          create: (context) => AddReminderCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.interTextTheme(),
          appBarTheme: AppBarTheme(
            backgroundColor: kPrimaryColor,
            elevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: kPrimaryColor,
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: kPrimaryColor,
                width: 2,
              ),
            ),
          ),
        ),
        routes: routes,
      ),
    );
  }
}
