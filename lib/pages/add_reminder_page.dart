part of 'pages.dart';

class AddReminderPage extends StatelessWidget {
  const AddReminderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addReminder = context.read<AddReminderCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text('Add pill')),
      body: Form(
        key: addReminder.key,
        child: ListView(
          children: [
            kBigVerticalSpacing,

            ///
            CustomTextField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Pill Name is required';
                }
                return null;
              },
              controller: addReminder.pillName,
              labelText: 'Pill name',
              hintText: 'eg: Pil KB',
            ),
            kMediumVerticalSpacing,

            ///
            CustomTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pill Amount is required';
                  }
                  return null;
                },
                controller: addReminder.pillAmount,
                labelText: 'Pill amount',
                hintText: '1',
                keyboardType: TextInputType.number),
            kMediumVerticalSpacing,

            ///
            BlocBuilder<AddReminderCubit, AddReminderState>(
              builder: (context, state) {
                return CustomDatePicker(
                  validator: (v) {
                    if (v == null) {
                      return 'Please set the time';
                    }
                    return null;
                  },
                  controller: addReminder.pillTime,
                  labelText: 'Time',
                  onChange: (v) {
                    addReminder.setDate(v!);
                    return null;
                  },
                  hintText: '07:00',
                );
              },
            ),
            kMediumVerticalSpacing,

            ///
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('How long this reminder will last?',
                  style: kBodyTextBold),
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
                          ? Row(
                              children: [
                                const Text(
                                  'I want to set this reminder for',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                                Text(
                                  ' ${addReminder.day.round()} days',
                                )
                              ],
                            )
                          : Row(
                              children: [
                                const Text(
                                  'I want to set this reminder for',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                                Text(' ${addReminder.day.round()} day')
                              ],
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Frequence is needed';
                          }
                          return null;
                        },
                        labelText: 'How many times',
                        hintText: '1x',
                        padding: 0,
                        controller: addReminder.pillTimes,
                        keyboardType: TextInputType.number),
                  ),
                  kSmallHorizontalSpacing,
                  BlocBuilder<AddReminderCubit, AddReminderState>(
                    builder: (context, state) => Expanded(
                      child: CustomTextField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Frequence is needed';
                          }
                          return null;
                        },
                        labelText: 'Consumption Interval',
                        hintText: '5 (hours)',
                        padding: 0,
                        controller: addReminder.pillConsumption,
                        keyboardType: addReminder.pillTimes.toString() == '1'
                            ? TextInputType.none
                            : TextInputType.number,
                        enabled: addReminder.pillTimes.toString() == '1'
                            ? false
                            : true,
                      ),
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
                      (index) =>
                          BlocBuilder<AddReminderCubit, AddReminderState>(
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
                                      ? Border.all(
                                          color: kPrimaryColor, width: 2)
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
                loading: () => const CustomButton(
                  child: Text('Loading...'),
                  onTap: null,
                ),
                orElse: () => CustomButton(
                  child: const Text('Simpan'),
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    if (addReminder.key.currentState!.validate()) {
                      if (int.parse(addReminder.pillTimes.text) > 1 &&
                          int.parse(addReminder.pillConsumption.text) < 1) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'Consumption interval must not be 0',
                            ),
                          ),
                        );
                      }
                      if (addReminder.selectedCategory == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'Please choose pill category',
                            ),
                          ),
                        );
                      }
                      if (int.parse(addReminder.pillTimes.text) == 1 &&
                          int.parse(addReminder.pillConsumption.text) > 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'Times per day must not be lower than interval',
                            ),
                          ),
                        );
                      } else {
                        context
                            .read<AddReminderCubit>()
                            .addReminder(context.read<UserCubit>().u);
                      }
                    }
                  },
                ),
              ),
            ),
            kBigVerticalSpacing,
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
        CustomButton(
          child: const Text('Simpan'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
            context.read<ReminderCubit>().getPill(
                  DateFormat('yyyy-MM-dd').format(
                    DateTime.now(),
                  ),
                );
          },
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
