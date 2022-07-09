part of 'widgets.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final int? maxLines;
  final String hintText;

  const CustomTextField({
    Key? key,
    this.maxLines,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      onChanged: (value) {},
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        isDense: true,
        contentPadding: const EdgeInsets.fromLTRB(15, 15, 0, 10),
        hintText: hintText,
        suffix: GestureDetector(
          onTap: () {},
          child: const Padding(
            padding: EdgeInsets.only(
              right: 10,
            ),
          ),
        ),
        hintStyle: const TextStyle(color: Color(0xffAFC6CB), fontSize: 14),
        filled: true,
        fillColor: const Color(0xffF0F4F4),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(color: Colors.transparent, width: 2),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(color: Colors.transparent, width: 2),
        ),
      ),
    );
  }
}
