part of 'pages.dart';

class AddressPage extends StatefulWidget {
  final User user;
  final String password;
  final File pictureFile;

  const AddressPage(this.user, this.password, this.pictureFile, {Key key})
      : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController houseNumController = TextEditingController();
  bool isLoading = false;
  List<String> cities;
  String selectedCity;

  @override
  void initState() {
    super.initState();

    cities = ['Bandung', 'Jakarta', 'Surabaya'];
    selectedCity = cities[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/onboarding3.jpg'),
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
                      controller: phoneController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone),
                        hintStyle: greyFontStyle,
                        hintText: 'Type your phone number',
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
                      controller: addressController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.location_on),
                        hintStyle: greyFontStyle,
                        hintText: 'Type your address',
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
                      controller: houseNumController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.house),
                        hintStyle: greyFontStyle,
                        hintText: 'Type your house number',
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin:
                        const EdgeInsets.symmetric(horizontal: defaultMargin),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black)),
                    child: DropdownButton(
                        value: selectedCity,
                        isExpanded: true,
                        underline: const SizedBox(),
                        items: cities
                            .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: blackFontStyle3,
                                )))
                            .toList(),
                        onChanged: (item) {
                          setState(() {
                            selectedCity = item;
                          });
                        }),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 24),
                    height: 45,
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: (isLoading == true)
                        ? Center(
                            child: loadingIndicator,
                          )
                        : ElevatedButton(
                            onPressed: () async {
                              User user = widget.user.copyWith(
                                  phoneNumber: phoneController.text,
                                  address: addressController.text,
                                  houseNumber: houseNumController.text,
                                  city: selectedCity);

                              setState(() {
                                isLoading = true;
                              });

                              await context.read<UserCubit>().signUp(
                                  user, widget.password,
                                  pictureFile: widget.pictureFile);

                              UserState state = context.read<UserCubit>().state;

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
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              primary: mainColor,
                            ),
                            child: Text(
                              'Sign Up Now',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
