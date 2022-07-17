part of 'pages.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) => state.maybeWhen(
        loaded: (user) => Navigator.pushReplacementNamed(
          context,
          mainPage,
          arguments: user,
        ),
        error: (t) => Navigator.pushReplacementNamed(
          context,
          login,
        ),
        orElse: () {
          return null;
        },
      ),
      child: Scaffold(
        body: Center(
          child: Container(
            width: 222,
            height: 222,
            margin: const EdgeInsets.only(bottom: 50),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/logo.png',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
