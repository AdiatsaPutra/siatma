part of 'pages.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 222,
          height: 222,
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/splash_image.png',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
