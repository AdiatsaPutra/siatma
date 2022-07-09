import 'package:flutter/material.dart';

import 'pages/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/main-page': (context) => const MainPage(),
        '/home-page': (context) => const HomePage(),
        '/add-reminder-page': (context) => const AddReminderPage(),
        '/empty-reminder-page': (context) => const EmptyReminderPage(),
      },
    );
  }
}
