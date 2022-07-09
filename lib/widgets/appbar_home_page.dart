part of 'widgets.dart';

class AppBarHomePage extends StatelessWidget {
  final User user;

  const AppBarHomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userPill = context.read<ReminderCubit>();
    return Scaffold(
        body: Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
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
              kBigVerticalSpacing,
            ]),
          ),
        ),
        CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: DateTime(2022),
          lastDate: DateTime(2100),
          onDateSelected: (date) {
            userPill.getPill(
              DateFormat('yyyy-MM-dd').format(date!),
            );
          },
          leftMargin: 20,
          monthColor: Colors.black,
          dayColor: kPrimaryColor,
          activeDayColor: kPrimaryColor,
          activeBackgroundDayColor: kPrimaryBgColor,
          dotsColor: Colors.white,
          locale: 'id',
        ),
      ],
    ));
  }
}
