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
            controller: addReminder.pillName,
            labelText: 'Pill name',
            hintText: 'eg: Pil KB',
          ),
          kMediumVerticalSpacing,

          ///
          CustomTextField(
            controller: addReminder.pillAmount,
            labelText: 'Pill amount',
            hintText: '1',
          ),
          kMediumVerticalSpacing,

          ///
          BlocBuilder<AddReminderCubit, AddReminderState>(
            builder: (context, state) {
              return CustomDatePicker(
                controller: addReminder.pillTime,
                labelText: 'Time',
                onChange: (v) {
                  addReminder.setDate(v!);
                  //  return null;
                },
                hintText: '07:00',
              );
            },
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
                        value: addReminder.day,
                        max: 50,
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
                    builder: (context, state) => addReminder.day.round() > 1
                        ? Text(
                            '${addReminder.day.round()} days',
                          )
                        : Text(
                            '${addReminder.day.round()} day',
                          ),
                  ),
                ),
                kSmallVerticalSpacing,
              ],
            ),
          ),

          ///
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('Times per day', style: kBodyTextBold),
          ),
          kMediumVerticalSpacing,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    labelText: 'How many times',
                    hintText: '1x',
                    padding: 0,
                    controller: addReminder.pillTimes,
                  ),
                ),
                kSmallHorizontalSpacing,
                Expanded(
                  child: CustomTextField(
                    labelText: 'Consumption Interval',
                    hintText: '5 (hours)',
                    padding: 0,
                    controller: addReminder.pillConsumption,
                  ),
                ),
              ],
            ),
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
                            margin: EdgeInsets.fromLTRB(
                                index == 0 ? 20 : 0, 16, 10, 16),
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
          BlocConsumer<AddReminderCubit, AddReminderState>(
            listener: (context, state) => state.maybeWhen(
              success: () => showDialog(
                context: context,
                builder: (context) => const Dialog(
                  child: AlertSection(),
                ),
              ),
              orElse: () {
                return null;
              },
            ),
            builder: (context, state) => state.maybeWhen(
              loading: () => const Padding(
                padding: EdgeInsets.all(10.0),
                child: CustomButton(
                  child: Text('Loading...'),
                  onTap: null,
                ),
              ),
              orElse: () => Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomButton(
                  child: const Text('Simpan'),
                  onTap: () {
                    context.read<AddReminderCubit>().addReminder();
                  },
                ),
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
    final addReminder = context.read<AddReminderCubit>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/reminder_added.png',
          height: 200,
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
              // addReminder.pillName.clear();
              // addReminder.pillAmount.clear();
              // addReminder.pillTime.clear();
              // addReminder.pillTimes.clear();
              // //  addReminder.time = null;
              // addReminder.day = 1;
              // addReminder.pillConsumption.clear();
              // addReminder.selectedCategory = null;
              Navigator.pop(context);
              Navigator.pop(context);
              context.read<ReminderCubit>().getPill(
                    DateFormat('yyyy-MM-dd').format(
                      DateTime.now(),
                    ),
                  );
            },
          ),
        ),
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
