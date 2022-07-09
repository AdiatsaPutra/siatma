part of 'pages.dart';

class AddReminderPage extends StatelessWidget {
  const AddReminderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: Column(
          children: [
            Container(
              color: const Color(0xff3B5BFF),
              height: 30,
            ),
            Container(
              color: const Color(0xff3B5BFF),
              height: 50,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_outlined,
                          color: Colors.white, size: 24)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: const Center(
                      child: Text(
                        'Tambah Reminder ',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Tambah Remindermu',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 16,
            ),
            const CustomTextField(hintText: 'Judul'),
            const SizedBox(
              height: 16,
            ),
            const CustomTextField(hintText: 'Tanggal'),
            const SizedBox(
              height: 16,
            ),
            const CustomTextField(
              hintText: 'Deskripsi',
              maxLines: 10,
            ),
            const SizedBox(
              height: 16,
            ),
            SubmitButton(
              onTap: () => showModalBottomSheet(
                backgroundColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                //  isDismissible: true,
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return const FractionallySizedBox(
                    heightFactor: 0.95,
                    child: AlertSection(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AlertSection extends StatelessWidget {
  const AlertSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 120,
          height: 250,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/reminder_added.png',
                  height: 100,
                ),
              ),
              const Text(
                'Reminder Ditambah',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SubmitButton(onTap: () {}),
              )
            ],
          ),
        ),
      ),
    );
  }
}
