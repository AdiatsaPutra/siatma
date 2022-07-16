part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final reminder = context.read<ReminderCubit>();
    final addReminder = context.read<AddReminderCubit>();
    var randomNumber = Random().nextInt(9);
    final user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(230),
        child: AppBarHomePage(user: user),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          BlocListener<AddReminderCubit, AddReminderState>(
            listener: (context, state) => state.maybeWhen(
              success: () => reminder.getPill(
                DateFormat('yyyy-MM-dd').format(
                  DateTime.now(),
                ),
              ),
              orElse: () {
                return null;
              },
            ),
            child: BlocBuilder<ReminderCubit, ReminderState>(
              builder: (context, state) => state.maybeWhen(
                error: (e) => Text(e),
                orElse: () {
                  if (reminder.userPill.isEmpty) {
                    return const EmptyReminder();
                  }
                  return Column(
                    children: [
                      ...reminder.userPill.map(
                        (e) {
                          return TileReminder(
                            userPill: e,
                            onTapDelete: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Anda yakin akan menghapus pengingat ini?',
                                          style: kBodyText,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: OutlinedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Batal'),
                                              ),
                                            ),
                                            kBigHorizontalSpacing,
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  addReminder.deleteReminder(e);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Ok'),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            icon: Icon(
                              e.isDone == 0
                                  ? Icons.circle_outlined
                                  : Icons.check_circle,
                              color: e.isDone == 1
                                  ? kSecondaryColor
                                  : Colors.grey[300],
                            ),
                            onTapDone: e.isDone == 1
                                ? null
                                : () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Anda yakin akan check pengingat ini?',
                                                style: kBodyText,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: OutlinedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text('Batal'),
                                                    ),
                                                  ),
                                                  kBigHorizontalSpacing,
                                                  Expanded(
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        addReminder
                                                            .editReminder(
                                                          e,
                                                          0,
                                                        );
                                                        Navigator.pop(context);
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              Dialog(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  ...quotes
                                                                      .where((element) =>
                                                                          element
                                                                              .id ==
                                                                          randomNumber)
                                                                      .map(
                                                                        (e) =>
                                                                            Text(
                                                                          e.quote,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                          ),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      ),
                                                                  SizedBox(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    child:
                                                                        ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: const Text(
                                                                          'Ok'),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: const Text('Ok'),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                          );
                        },
                      )
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

class ReminderDay extends StatelessWidget {
  final String date;
  const ReminderDay({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            date,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
