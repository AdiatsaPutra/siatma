import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:si_atma/blocs/add_reminder/add_reminder_cubit.dart';
import 'package:si_atma/blocs/reminder/reminder_cubit.dart';
import 'package:si_atma/blocs/user/user_cubit.dart';
import 'package:si_atma/constants/constants.dart';
import 'package:si_atma/constants/routes.dart';

import 'notification/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
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
        ),
        routes: routes,
      ),
    );
  }
}
