part of 'pages.dart';

class EmptyReminder extends StatelessWidget {
  const EmptyReminder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          kBiggestVerticalSpacing,
          Image.asset(
            'assets/empty_reminder_background.png',
            width: 150,
            height: 300,
          ),
          kMediumVerticalSpacing,
          Text(
            'No reminder yet',
            style: kMediumTextBold,
          ),
        ],
      ),
    );
  }
}
