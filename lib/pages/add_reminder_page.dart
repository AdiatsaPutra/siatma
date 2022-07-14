part of 'pages.dart';

class AddReminderPage extends StatelessWidget {
  const AddReminderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addReminder = context.read<AddReminderCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah pil')),
      body: Form(
        key: addReminder.key,
        child: ListView(
          children: [
            kBigVerticalSpacing,

            ///
            CustomTextField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama pil wajib diisi';
                }
                return null;
              },
              controller: addReminder.pillName,
              labelText: 'Nama pil',
              hintText: 'contoh: Pil KB',
            ),
            kMediumVerticalSpacing,

            ///
            CustomTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jumlah pil wajib diisi';
                  }
                  return null;
                },
                controller: addReminder.pillAmount,
                labelText: 'Jumlah pil',
                hintText: '1',
                keyboardType: TextInputType.number),
            kMediumVerticalSpacing,

            ///
            BlocBuilder<AddReminderCubit, AddReminderState>(
              builder: (context, state) {
                return CustomDatePicker(
                  validator: (v) {
                    if (v == null) {
                      return 'Atur waktu';
                    }
                    return null;
                  },
                  controller: addReminder.pillTime,
                  labelText: 'Waktu',
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
                          max: 180,
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
                        builder: (context, state) => Row(
                              children: [
                                const Text(
                                  'Reminder akan diset selama',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                                (addReminder.day > 7)
                                    ? Text(
                                        ' ${addReminder.day.round()} hari (${(addReminder.day / 7).round()}) minggu',
                                      )
                                    : Text(
                                        ' ${addReminder.day.round()} hari',
                                      )
                              ],
                            )),
                  ),
                  kSmallVerticalSpacing,
                ],
              ),
            ),

            ///
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Waktu per hari', style: kBodyTextBold),
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
                            return 'Frekuensi wajib diisi';
                          }
                          return null;
                        },
                        labelText: 'Berapa kali konsumsi',
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
                            return 'Rentang wajib diisi';
                          }
                          return null;
                        },
                        labelText: 'Rentang konsumsi obat',
                        hintText: '5 (jam)',
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
              child: Text('Tipe pil', style: kBodyTextBold),
            ),
            SizedBox(
              height: 150,
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
                            child: Column(children: [
                              kBigVerticalSpacing,
                              Image.asset(
                                buildPillType(context, index),
                                width: 60,
                              ),
                              kSmallVerticalSpacing,
                              Text(
                                buildCategory(context, index),
                                style: kSmallTextBold,
                              )
                            ]),
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
                          ),
                        );
                      },
                    ),
                  ),
                ],
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
                              'Rentang konsumsi tidak boleh 0',
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
                              'Frekuensi tidak boleh kurang dari atau sama dengan rentang waktu konsumsi',
                            ),
                          ),
                        );
                      } else {
                        if (addReminder.selectedCategory == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                'Tipe pil belum anda pilih',
                              ),
                            ),
                          );
                        }
                        if (addReminder.selectedCategory != null) {
                          context
                              .read<AddReminderCubit>()
                              .addReminder(context.read<UserCubit>().u);
                        }
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

buildPillType(BuildContext context, int index) {
  switch (index) {
    case 0:
      return 'assets/pills.png';
    case 1:
      return 'assets/pills-bottle.png';
    case 2:
      return 'assets/cream.png';
    case 3:
      return 'assets/injection.png';
    case 4:
      return 'assets/eye-dropper.png';
    default:
      return '';
  }
}

String buildCategory(BuildContext context, int index) {
  switch (index) {
    case 0:
      return 'Tablet';
    case 1:
      return 'Capsule';
    case 2:
      return 'Cream';
    case 3:
      return 'Suntik';
    case 4:
      return 'Tetes';
    default:
      return '';
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
          child: const Text('Ok'),
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
        kBigVerticalSpacing,
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
