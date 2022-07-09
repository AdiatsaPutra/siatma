import '../pages/pages.dart';

const String root = '/';
const String login = '/login';
const String mainPage = '/main-page';
const String homePage = '/home-page';
const String addReminderPage = '/add-reminder-page';
const String emptyReminderPage = '/empty-reminder-page';

final routes = {
  root: (context) => const SplashPage(),
  login: (context) => const LoginPage(),
  mainPage: (context) => const MainPage(),
  homePage: (context) => const HomePage(),
  addReminderPage: (context) => const AddReminderPage(),
  emptyReminderPage: (context) => const EmptyReminderPage(),
};
