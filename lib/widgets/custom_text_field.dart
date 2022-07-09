part of 'widgets.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final int? maxLines;
  final String labelText;
  final String hintText;
  final Key? keey;
  final String? Function(String?)? validator;

  const CustomTextField(
      {Key? key,
      this.keey,
      this.maxLines,
      required this.labelText,
      required this.hintText,
      required this.controller,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: keey,
        child: TextFormField(
          validator: validator,
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
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.blueGrey),
            hintText: hintText,
            suffix: GestureDetector(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.only(
                  right: 10,
                ),
              ),
            ),
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
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
        ),
      ),
    );
  }
}
