part of 'pages.dart';

class EmptyReminderPage extends StatelessWidget {
  const EmptyReminderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(110),
        child: AppBarHomePage(),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/empty_reminder_background.png',
            width: 150,
            height: 300,
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Belum ada Reminder',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ],
      )),
    );
  }
}
