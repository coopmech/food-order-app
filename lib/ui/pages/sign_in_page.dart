part of 'pages.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: Colors.yellow,
              child: Image.asset('assets/love_burger.png'),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(60),
                    topLeft: Radius.circular(60),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Welcome!',
                        style: blackFontStyle1.copyWith(
                          color: secondaryColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      margin:
                          const EdgeInsets.symmetric(horizontal: defaultMargin),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone),
                          hintStyle: greyFontStyle,
                          hintText: 'Type your email address',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      margin:
                          const EdgeInsets.symmetric(horizontal: defaultMargin),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.remove_red_eye,
                            ),
                            onPressed: _toggle,
                          ),
                          hintStyle: greyFontStyle,
                          hintText: 'Type your password',
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultMargin),
                        child: Text(
                          'Forgot password?',
                          style: greyFontStyle.copyWith(fontSize: 11),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 30),
                      height: 45,
                      padding:
                          const EdgeInsets.symmetric(horizontal: defaultMargin),
                      child: isLoading
                          ? loadingIndicator
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(75)),
                                primary: mainColor,
                              ),
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });

                                await context.read<UserCubit>().signIn(
                                    emailController.text,
                                    passwordController.text);
                                UserState state =
                                    context.read<UserCubit>().state;

                                if (state is UserLoaded) {
                                  context.read<FoodCubit>().getFoods();
                                  context
                                      .read<TransactionCubit>()
                                      .getTransactions();
                                  Get.to(const MainPage());
                                } else {
                                  Get.snackbar("", "",
                                      backgroundColor: "D9435E".toColor(),
                                      icon: const Icon(
                                        MdiIcons.closeCircleOutline,
                                        color: Colors.white,
                                      ),
                                      titleText: Text(
                                        "Sign In Failed",
                                        style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      messageText: Text(
                                        (state as UserLoadingFailed).message,
                                        style: GoogleFonts.poppins(
                                            color: Colors.white),
                                      ));
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              },
                              child: Text(
                                'Sign In',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 24),
                      height: 45,
                      padding:
                          const EdgeInsets.symmetric(horizontal: defaultMargin),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(75)),
                          primary: greyColor,
                        ),
                        onPressed: () {
                          Get.to(const SignUpPage());
                        },
                        child: Text(
                          'Create New Account',
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Stack(
                      children: [
                        const Divider(
                          thickness: 1,
                          color: Colors.black,
                          indent: 85,
                          endIndent: 85,
                        ),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            color: Colors.white,
                            child: const Text('OR continue with'),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.facebook,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 10),
                        FaIcon(
                          FontAwesomeIcons.google,
                          color: Colors.orange[700],
                        ),
                        const SizedBox(width: 10),
                        const FaIcon(
                          FontAwesomeIcons.apple,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
