part of 'pages.dart';

class AddReminderPage extends StatelessWidget {
  const AddReminderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addReminder = context.read<AddReminderCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text('Add pill')),
      body: ListView(
        children: [
          kBigVerticalSpacing,

          ///
          CustomTextField(
            controller: TextEditingController(),
            labelText: 'Pill name',
            hintText: 'eg: Pil KB',
          ),
          kMediumVerticalSpacing,

          ///
          CustomTextField(
            controller: TextEditingController(),
            labelText: 'Pill amount',
            hintText: '1',
          ),
          kMediumVerticalSpacing,

          ///
          CustomTextField(
            controller: TextEditingController(),
            labelText: 'Time',
            hintText: '07:00',
          ),
          kMediumVerticalSpacing,

          ///
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:
                Text('How long this reminder will last?', style: kBodyTextBold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                SliderTheme(
                  data: SliderThemeData(
                    thumbColor: kPrimaryColor,
                    overlayColor: kPrimaryBgColor,
                    activeTrackColor: kPrimaryColor,
                    trackShape: SliderCustomTrackShape(),
                  ),
                  child: BlocBuilder<AddReminderCubit, AddReminderState>(
                    builder: (context, state) {
                      return Slider(
                        value: addReminder.week,
                        max: 100,
                        min: 1,
                        onChanged: (v) {
                          addReminder.setWeek(v);
                        },
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: BlocBuilder<AddReminderCubit, AddReminderState>(
                    builder: (context, state) => addReminder.week.round() > 1
                        ? Text(
                            '${addReminder.week.round()} weeks',
                          )
                        : Text(
                            '${addReminder.week.round()} week',
                          ),
                  ),
                ),
                kMediumVerticalSpacing,
              ],
            ),
          ),

          ///
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('Times per day', style: kBodyTextBold),
          ),
          kSmallVerticalSpacing,
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  labelText: 'How many times',
                  hintText: '1x',
                  controller: TextEditingController(),
                ),
              ),
              kSmallHorizontalSpacing,
              Expanded(
                child: CustomTextField(
                  labelText: 'Consumption Interval',
                  hintText: '5',
                  controller: TextEditingController(),
                ),
              ),
            ],
          ),
          kBigVerticalSpacing,

          ///
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('Pill type', style: kBodyTextBold),
          ),
          SizedBox(
            height: 150,
            child: Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  kBigVerticalSpacing,
                  ...List.generate(
                    5,
                    (index) => BlocBuilder<AddReminderCubit, AddReminderState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            addReminder.setCategory(index);
                          },
                          child: Container(
                            width: 100,
                            height: 50,
                            margin: const EdgeInsets.fromLTRB(0, 16, 10, 16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: addReminder.selectedCategory == index
                                    ? Border.all(color: kPrimaryColor, width: 2)
                                    : null,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 3,
                                    color: Colors.grey[200]!,
                                  )
                                ]),
                            //   child: Image.asset('assets/kapsul.jpg'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          ///
          CustomButton(
            child: const Text('Simpan'),
            onTap: () => showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const AlertSection(),
              ),
            ),
          ),
          kBigVerticalSpacing,
        ],
      ),
    );
  }
}

class AlertSection extends StatelessWidget {
  const AlertSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/reminder_added.png',
            height: 200,
          ),
        ),
        Text(
          'Reminder Ditambah',
          style: kBigTextBold,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomButton(
            child: const Text('Simpan'),
            onTap: () {
              UserPillRepository.createUserPill();
              context.read<ReminderCubit>().getPill(DateTime.now().toString());
            },
          ),
        )
      ],
    );
  }
}

class SliderCustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
