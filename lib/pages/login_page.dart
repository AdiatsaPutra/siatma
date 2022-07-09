part of 'pages.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/background_login.jpg',
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                height: 3 * MediaQuery.of(context).size.height / 5,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 42,
                    ),
                    const Text(
                      'Masuk/Daftar',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(hintText: 'Name'),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextField(hintText: 'Password'),
                    const SizedBox(
                      height: 15,
                    ),
                    SubmitButton(
                      onTap: () {
                        Navigator.pushNamed(context, '/main-page');
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final int? maxLines;
  final String hintText;
  const CustomTextField({
    Key? key,
    this.maxLines,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
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

class SubmitButton extends StatelessWidget {
  final Function() onTap;
  const SubmitButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: onTap,
          child: const Text(
            'Simpan',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              vertical: 14,
            ),
            primary: Color(0xff3152FF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        )
      ],
    );
  }
}
  
              // () {
              //       Navigator.pushNamed(context, '/sign-up');
              //     },