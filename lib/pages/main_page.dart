part of 'pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    EmptyReminder()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final addReminder = context.read<AddReminderCubit>();
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Image.asset(
                      'assets/bar_reminder.jpg',
                      height: 16,
                    ),
                    const SizedBox(
                      height: 2,
                    )
                  ],
                ),
                label: 'Reminders',
              ),
              BottomNavigationBarItem(
                icon: Column(
                  children: const [
                    Icon(Icons.format_quote_sharp),
                    SizedBox(
                      height: 2,
                    )
                  ],
                ),
                label: 'Quotes',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: const Color(0xff3152FF),
            onTap: _onItemTapped,
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 25,
            top: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: GestureDetector(
                child: const Icon(
                  Icons.add_circle,
                  size: 50,
                  color: Color(0xff3152FF),
                ),
                onTap: () {
                  addReminder.pillName.clear();
                  addReminder.pillAmount.clear();
                  addReminder.pillTime.clear();
                  addReminder.pillTimes.clear();
                  addReminder.time = null;
                  addReminder.day = 1;
                  addReminder.pillConsumption.clear();
                  addReminder.selectedCategory = null;
                  Navigator.pushNamed(context, addReminderPage);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
