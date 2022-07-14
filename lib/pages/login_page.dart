part of 'pages.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final login = context.read<UserCubit>();
    return Scaffold(
      body: Form(
        key: login.key,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: ListView(
            children: [
              const SizedBox(height: 200),
              Center(
                child: Image.asset(
                  'assets/splash_image.png',
                  width: 200,
                ),
              ),
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
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
                controller: login.name,
                labelText: 'Nama',
                hintText: 'Nama',
              ),
              kMediumVerticalSpacing,

              ///
              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  return CustomTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password wajib diisi';
                      }
                      if (int.parse(value) < 6) {
                        return 'Minimal 6 digit';
                      }
                      return null;
                    },
                    controller: login.password,
                    labelText: 'Password',
                    hintText: 'Minimal 6 digit',
                    isObscure: login.isObscure,
                    maxLines: 1,
                    suffix: GestureDetector(
                      onTap: () {
                        login.setObscure();
                      },
                      child: Icon(
                        login.isObscure
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: kPrimaryColor,
                      ),
                    ),
                  );
                },
              ),
              kMediumVerticalSpacing,

              ///
              BlocConsumer<UserCubit, UserState>(
                listener: (context, state) => state.maybeWhen(
                  loaded: (user) {
                    login.name.clear();
                    login.password.clear();
                    Navigator.pushNamed(
                      context,
                      mainPage,
                      arguments: user,
                    );
                    return null;
                  },
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
                      if (login.key.currentState!.validate()) {
                        login.login();
                      }
                    },
                  ),
                ),
              ),
              kBigVerticalSpacing,
            ],
          ),
        ),
      ),
    );
  }
}
