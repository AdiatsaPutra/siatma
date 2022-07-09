part of 'pages.dart';

class AddReminderPage extends StatelessWidget {
  const AddReminderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add your reminder')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            kMediumVerticalSpacing,
            const Text(
              'Tambah Remindermu',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            kMediumVerticalSpacing,
            CustomTextField(
                controller: TextEditingController(), hintText: 'Judul'),
            kMediumVerticalSpacing,
            CustomTextField(
                controller: TextEditingController(), hintText: 'Tanggal'),
            kMediumVerticalSpacing,
            CustomTextField(
              controller: TextEditingController(),
              hintText: 'Deskripsi',
              maxLines: 10,
            ),
            kMediumVerticalSpacing,
            CustomButton(
              child: const Text('Simpan'),
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
                child: CustomButton(child: const Text('Simpan'), onTap: () {}),
              )
            ],
          ),
        ),
      ),
    );
  }
}
