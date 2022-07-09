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
          Form(
            key: user.key,
            child: Positioned(
              bottom: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 3 * MediaQuery.of(context).size.height / 5,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kBiggestVerticalSpacing,

                      ///
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text('Masuk/Daftar', style: kBodyTextBold),
                      ),
                      kBigVerticalSpacing,

                      ///
                      CustomTextField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                        controller: user.name,
                        labelText: 'Name',
                        hintText: 'John',
                      ),
                      kMediumVerticalSpacing,

                      ///
                      CustomTextField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                        controller: user.password,
                        labelText: 'Password',
                        hintText: 'Minimum 6 Digits',
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
                              if (user.key.currentState!.validate()) {
                                user.login();
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
