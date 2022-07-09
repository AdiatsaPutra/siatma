part of 'pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    EmptyReminderPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    SizedBox(
                      height: 2,
                    )
                  ],
                ),
                label: 'Reminders',
              ),
              BottomNavigationBarItem(
                icon: Column(
                  children: [
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
            selectedItemColor: Color(0xff3152FF),
            onTap: _onItemTapped,
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 25,
            top: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: GestureDetector(
                child: Container(
                  child: Icon(
                    Icons.add_circle,
                    size: 50,
                    color: Color(0xff3152FF),
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/add-reminder-page');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
