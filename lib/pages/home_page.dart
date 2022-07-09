part of 'pages.dart';

// class Date{
//     DateTime now = DateTime.now();
//     var formatterDate = DateFormat('dd MMMM yyyy');
//     var formatterTime = DateFormat('kk:mm');
//     String actualDate = formatterDate.format(now);
//     String actualTime = formatterTime.format(now);
// }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> selectedCategory = [];
  final List<int> todayCategory = [3, -1, -2, 2, 1];
  final List<int> yesterdayCategory = [3, -2, 2, 5];
  @override
  Widget build(BuildContext context) {
    final String cdate1 = DateFormat("EEEEE").format(DateTime.now());

    DateTime now = DateTime.now();
    var formatterDate = DateFormat('dd MMMM yyyy');
    var formatterTime = DateFormat('kk:mm');
    String actualDate = formatterDate.format(now);
    String actualTime = formatterTime.format(now);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(110),
        child: AppBarHomePage(),
      ),
      body: ListView(
        children: [
          ReminderDay(
            date: 'Hari ini',
          ),
          Column(
            children: generateReminderWidgets(context, dateList: todayCategory),
          ),
          ReminderDay(
            date: actualDate,
          ),
          Column(
            children:
                generateReminderWidgets(context, dateList: yesterdayCategory),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  List<Widget> generateReminderWidgets(BuildContext context,
      {required List dateList}) {
    return dateList //masing masing elemen ada HelpUsContainer
        .map(
          (e) => CardReminder(
            ketentuan: e, //elemen dari llist genre
            isSelected:
                selectedCategory.contains(e), //isSelectednya true kalo dipencet
            onTap: () {
              onSelectCategory(e); //genre yg ditap
            }, // ketentuan: '',
          ),
        )
        .toList();
  }

  void onSelectCategory(int help) {
    if (selectedCategory.contains(help)) {
      //kalo udah ada berarti hapus category
      setState(() {
        selectedCategory.remove(help);
      });
    } else {
      if (selectedCategory.length < 10) {
        //berarti pilih 4
        setState(() {
          selectedCategory.add(help);
        });
      }
    }
  }
}

class ReminderDay extends StatelessWidget {
  final String date;
  const ReminderDay({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            date,
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class CardReminder extends StatelessWidget {
  final Function() onTap;
  final bool isSelected;
  final int ketentuan;
  const CardReminder({
    Key? key,
    required this.isSelected,
    required this.onTap,
    required this.ketentuan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    var formatterDate = DateFormat('dd MMMM yyyy');
    var formatterTime = DateFormat('kk:mm');
    String actualDate = formatterDate.format(now);
    String actualTime = formatterTime.format(now);
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 6,
              // offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/pill.jpg',
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Obat sakit perut',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            actualDate.toString(),
                            style: TextStyle(
                                color: Color(0xff7B8E93),
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: onTap,
                          icon: isSelected
                              ? Icon(
                                  Icons.check_circle,
                                  size: 32,
                                  color: Color(0xff47FFE9),
                                )
                              : Icon(
                                  Icons.circle_outlined,
                                  size: 32,
                                  color: Color(0xffF0F4F4),
                                ))
                    ],
                  ),
                ),
                ketentuan < 0
                    ? SizedBox()
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xffE9ECFF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  'Pil diminum $ketentuan kali',
                                  style: TextStyle(
                                      color: Color(0xff3B5BFF),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
              ],
            )),
      ),
    );
  }
}

class AppBarHomePage extends StatelessWidget {
  const AppBarHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              color: const Color(0xff3B5BFF),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(
                      height: 43,
                    ),
                    Center(
                      child: Text(
                        'Reminders',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Hi, Emely',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      'Here are your medicine reminders ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.normal),
                    ),
                  ]))),
    );
  }
}
