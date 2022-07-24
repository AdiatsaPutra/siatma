part of 'widgets.dart';

class AppBarHomePage extends StatelessWidget {
  final User user;

  const AppBarHomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addRingtone = context.read<AddReminderCubit>();
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
                  'Pengingat',
                  style: kMediumTextBold.copyWith(color: Colors.white),
                ),
              ),
              kMediumVerticalSpacing,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Hi, ${user.name}',
                      style: kBodyText.copyWith(color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          insetPadding: const EdgeInsets.all(20),
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            children: [
                              kBigVerticalSpacing,
                              const Center(
                                child: Text('Pilih Suara'),
                              ),
                              kBigVerticalSpacing,
                              ...List.generate(
                                5,
                                (index) => BlocBuilder<AddReminderCubit,
                                    AddReminderState>(
                                  builder: (context, state) {
                                    return GestureDetector(
                                      onTap: () {
                                        addRingtone.setRingtone(index);
                                        FlutterRingtonePlayer.play(
                                            fromAsset:
                                                buildRingtone(context, index));
                                        context.read<AddReminderCubit>();
                                      },
                                      child: Container(
                                        width: 20,
                                        child: Column(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              buildRingtoneName(context, index),
                                              style: kSmallTextBold,
                                            ),
                                          ),
                                        ]),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border:
                                                addRingtone.selectedRingtone ==
                                                        index
                                                    ? Border.all(
                                                        color: kPrimaryColor,
                                                        width: 2)
                                                    : null,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 1,
                                                spreadRadius: 3,
                                                color: Colors.grey[200]!,
                                              )
                                            ]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Ok'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              kSmallestVerticalSpacing,
              Text(
                'Jadwal minum obatmu tersedia di sini',
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

buildRingtone(BuildContext context, int index) {
  switch (index) {
    case 0:
      return 'assets/birds.mp3';
    case 1:
      return 'assets/cat_purring.mp3';
    case 2:
      return 'assets/koo_koo.mp3';
    case 3:
      return 'assets/lion_roar.mp3';
    case 4:
      return 'assets/water_flow.mp3';
    default:
      return '';
  }
}

String buildRingtoneName(BuildContext context, int index) {
  switch (index) {
    case 0:
      return 'Burung';
    case 1:
      return 'Kucing';
    case 2:
      return 'Burung Koo Koo';
    case 3:
      return 'Singa';
    case 4:
      return 'Air';
    default:
      return '';
  }
}
