part of 'pages.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserCubit>();
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
                    kBiggestVerticalSpacing,

                    ///
                    Text('Masuk/Daftar', style: kBodyTextBold),
                    kBigVerticalSpacing,

                    ///
                    CustomTextField(
                      controller: user.name,
                      hintText: 'Name',
                    ),
                    kMediumVerticalSpacing,

                    ///
                    CustomTextField(
                      controller: user.password,
                      hintText: 'Password',
                    ),
                    kMediumVerticalSpacing,

                    ///
                    BlocConsumer<UserCubit, UserState>(
                      listener: (context, state) => state.maybeWhen(
                        loaded: (user) => Navigator.pushNamed(
                          context,
                          mainPage,
                          arguments: user,
                        ),
                        orElse: () {
                          return null;
                        },
                      ),
                      builder: (context, state) => state.maybeWhen(
                        loading: () => const CustomButton(
                          child: Text('Loading...'),
                          onTap: null,
                        ),
                        orElse: () => CustomButton(
                          child: const Text('Simpan'),
                          onTap: () {
                            user.login();
                          },
                        ),
                      ),
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
