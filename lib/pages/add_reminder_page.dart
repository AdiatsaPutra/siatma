part of 'pages.dart';

class AddReminderPage extends StatelessWidget {
  const AddReminderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add pill')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            kBigVerticalSpacing,

            ///
            CustomTextField(
              controller: TextEditingController(),
              hintText: 'Pill name',
            ),
            kMediumVerticalSpacing,

            ///
            CustomTextField(
              controller: TextEditingController(),
              hintText: 'Pill amount',
            ),
            kMediumVerticalSpacing,

            ///
            Text('How long this reminder will last?', style: kBodyTextBold),
            SliderTheme(
              data: SliderThemeData(
                thumbColor: kPrimaryColor,
                overlayColor: kPrimaryBgColor,
                activeTrackColor: kPrimaryColor,
                trackShape: SliderCustomTrackShape(),
              ),
              child: Slider(
                value: 50,
                max: 100,
                onChanged: (v) {},
              ),
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: Text('1 week'),
            ),
            kMediumVerticalSpacing,

            ///
            Text('Times per day', style: kBodyTextBold),
            kSmallVerticalSpacing,
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: 'How many times',
                    controller: TextEditingController(),
                  ),
                ),
                kSmallHorizontalSpacing,
                Expanded(
                  child: CustomTextField(
                    hintText: 'Consumption Interval',
                    controller: TextEditingController(),
                  ),
                ),
              ],
            ),
            kBigVerticalSpacing,

            ///
            Text('Pill type', style: kBodyTextBold),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ...List.generate(
                    5,
                    (index) => Container(
                      width: 100,
                      height: 50,
                      margin: const EdgeInsets.fromLTRB(0, 16, 10, 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              spreadRadius: 3,
                              color: Colors.grey[200]!,
                            )
                          ]),
                    ),
                  ),
                ],
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
            onTap: () {},
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
