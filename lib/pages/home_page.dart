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
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
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
                              addReminder.deleteReminder(e);
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
                                    addReminder.editReminder(e, 0);
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
