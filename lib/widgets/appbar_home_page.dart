part of 'widgets.dart';

class AppBarHomePage extends StatelessWidget {
  final User user;

  const AppBarHomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          color: kPrimaryColor,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            kBiggestVerticalSpacing,
            Center(
              child: Text(
                'Reminders',
                style: kMediumTextBold.copyWith(color: Colors.white),
              ),
            ),
            kMediumVerticalSpacing,
            Text(
              'Hi, ${user.name}',
              style: kBodyTextBold.copyWith(color: Colors.white),
            ),
            kSmallestVerticalSpacing,
            Text(
              'Here are your medicine reminders ',
              style: kSmallText.copyWith(color: Colors.white),
            ),
          ]),
        ),
      ),
    );
  }
}
