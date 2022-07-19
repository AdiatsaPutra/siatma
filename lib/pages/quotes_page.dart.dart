part of 'pages.dart';

class QuotesPage extends StatelessWidget {
  const QuotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var randomNumber = Random().nextInt(9);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotes Kesehatan'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Anda yakin akan tutup aplikasi??'),
                          kBigVerticalSpacing,
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Jangan'),
                                ),
                              ),
                              kBigHorizontalSpacing,
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final SharedPreferences sharedPreferences =
                                        await SharedPreferences.getInstance();
                                    sharedPreferences.clear();
                                    NotificationService().clearNotification();
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, login, (route) => false);
                                  },
                                  child: const Text('Ya, tutup'),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: Text(
                'Keluar',
                style: kSmallText.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          GestureDetector(
            onTap: () {
              launchUrl(
                Uri.parse(
                  'https://www.alodokter.com/proses-terjadinya-penularan-tbc',
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://res.cloudinary.com/dk0z4ums3/image/upload/v1643599979/attached_image/proses-terjadinya-penularan-tbc-0-alodokter.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Proses Terjadinya Penularan TBC',
                          style: kMediumTextBold,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ...quotes.where((element) => element.id == randomNumber).map(
                (e) => Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/healthcare.png',
                          width: 30,
                        ),
                        kBigHorizontalSpacing,
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 120,
                          child: Text(e.quote, style: kBodyText),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            spreadRadius: 3,
                            color: Colors.grey[300]!,
                          ),
                        ]),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
