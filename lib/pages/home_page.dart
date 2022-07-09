part of 'pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // DateTime now = DateTime.now();
    // var formatterDate = DateFormat('dd MMMM yyyy');
    // String actualDate = formatterDate.format(now);
    final user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: AppBarHomePage(user: user),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          CalendarTimeline(
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime(2100),
            onDateSelected: (date) => print(date),
            leftMargin: 20,
            monthColor: Colors.black,
            dayColor: kPrimaryColor,
            activeDayColor: kPrimaryColor,
            activeBackgroundDayColor: kPrimaryBgColor,
            dotsColor: Colors.white,
            locale: 'id',
          ),
          TileReminder(
            isSelected: true,
            onTap: () {},
            ketentuan: 3,
          ),
          // Column(
          //   children: generateReminderWidgets(context, dateList: todayCategory),
          // ),
          // ReminderDay(
          //   date: '',
          // ),
          // Column(
          //   children:
          //       generateReminderWidgets(context, dateList: yesterdayCategory),
          // ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  // List<Widget> generateReminderWidgets(BuildContext context,
  //     {required List dateList}) {
  //   return dateList //masing masing elemen ada HelpUsContainer
  //       .map(
  //         (e) => CardReminder(
  //           ketentuan: e, //elemen dari llist genre
  //           isSelected:
  //               selectedCategory.contains(e), //isSelectednya true kalo dipencet
  //           onTap: () {
  //             onSelectCategory(e); //genre yg ditap
  //           }, // ketentuan: '',
  //         ),
  //       )
  //       .toList();
  // }

  // void onSelectCategory(int help) {
  //   if (selectedCategory.contains(help)) {
  //     //kalo udah ada berarti hapus category
  //     setState(() {
  //       selectedCategory.remove(help);
  //     });
  //   } else {
  //     if (selectedCategory.length < 10) {
  //       //berarti pilih 4
  //       setState(() {
  //         selectedCategory.add(help);
  //       });
  //     }
  //   }
  // }
}

class ReminderDay extends StatelessWidget {
  final String date;
  const ReminderDay({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            date,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
