part of 'widgets.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final Color? colorButton;
  final VoidCallback? onTap;

  const CustomButton({
    Key? key,
    required this.onTap,
    required this.child,
    this.colorButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: onTap,
            child: child,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                vertical: 14,
              ),
              primary: colorButton ?? kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          )
        ],
      ),
    );
  }
}
