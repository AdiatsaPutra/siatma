part of 'widgets.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final int? maxLines;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final double? padding;
  final bool? enabled;
  final TextInputType? keyboardType;
  final bool isObscure;
  final Widget? suffix;

  const CustomTextField({
    Key? key,
    this.maxLines,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.validator,
    this.padding,
    this.enabled,
    this.keyboardType,
    this.isObscure = false,
    this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding ?? 20),
      child: TextFormField(
        validator: validator,
        controller: controller,
        maxLines: maxLines,
        enabled: enabled ?? true,
        keyboardType: keyboardType,
        onChanged: (value) {},
        obscureText: isObscure,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(color: Colors.transparent, width: 2),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(color: Colors.transparent, width: 2),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(color: Colors.transparent, width: 2),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: labelText,
          isDense: true,
          labelStyle: TextStyle(color: kPrimaryColor),
          hintText: hintText,
          suffixIcon: suffix,
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
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(color: Colors.transparent, width: 2),
          ),
        ),
      ),
    );
  }
}
