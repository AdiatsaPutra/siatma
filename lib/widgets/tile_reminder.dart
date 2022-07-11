part of 'widgets.dart';

class TileReminder extends StatelessWidget {
  final UserPill userPill;
  final VoidCallback onTap;
  final bool isSelected;

  const TileReminder({
    Key? key,
    required this.isSelected,
    required this.onTap,
    required this.userPill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 6,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/pill.jpg',
                      width: 20,
                      height: 20,
                    ),
                    kMediumHorizontalSpacing,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userPill.name, style: kMediumTextBold),
                        Text(
                          userPill.time,
                          style: kBodyText.copyWith(
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: onTap,
                      icon: isSelected
                          ? const Icon(
                              Icons.check_circle,
                              size: 32,
                              color: Color(0xff47FFE9),
                            )
                          : const Icon(
                              Icons.circle_outlined,
                              size: 32,
                              color: Color(0xffF0F4F4),
                            ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xffE9ECFF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'Pil amount: ${userPill.amount}',
                          style: kBodyTextBold.copyWith(color: kPrimaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
