part of 'widgets.dart';

class CustomDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final int? maxLines;
  final String labelText;
  final String hintText;
  final String? Function(DateTime?)? validator;
  final String? Function(DateTime?)? onChange;
  final double? padding;

  const CustomDatePicker(
      {Key? key,
      this.maxLines,
      required this.labelText,
      required this.hintText,
      required this.controller,
      this.validator,
      this.padding,
      required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("yyyy-MM-dd HH:mm");
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding ?? 20),
      child: DateTimeField(
        resetIcon: const Icon(Icons.close),
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );

            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
        validator: validator,
        controller: controller,
        onChanged: onChange,
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
          isDense: true,
          contentPadding: const EdgeInsets.fromLTRB(15, 15, 0, 10),
          labelText: labelText,
          labelStyle: TextStyle(color: kPrimaryColor),
          hintText: hintText,
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
