part of 'pages.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({Key key}) : super(key: key);

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double listItemWidth =
        MediaQuery.of(context).size.width - 2 * defaultMargin;

    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/onboarding2.png'),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: defaultMargin, top: 60, right: 24),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Food Order',
                      style: blackFontStyle1.copyWith(
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                    TextSpan(
                      text: ' App',
                      style: blackFontStyle1.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: defaultMargin,
                      top: 10,
                    ),
                    child: Text('Popular', style: blackFontStyle1),
                  ),
                  SizedBox(
                    height: 258,
                    width: double.infinity,
                    child: BlocBuilder<FoodCubit, FoodState>(
                      builder: (_, state) => (state is FoodLoaded)
                          ? ListView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: [
                                Row(
                                  children: state.foods
                                      .map((e) => Padding(
                                            padding: EdgeInsets.only(
                                                left: (e == state.foods.first)
                                                    ? defaultMargin
                                                    : 0,
                                                right: defaultMargin),
                                            child: GestureDetector(
                                                onTap: () {
                                                  Get.to(FoodDetailsPage(
                                                    transaction: Transaction(
                                                        food: e,
                                                        user: (context
                                                                    .read<
                                                                        UserCubit>()
                                                                    .state
                                                                as UserLoaded)
                                                            .user),
                                                    onBackButtonPressed: () {
                                                      Get.back();
                                                    },
                                                  ));
                                                },
                                                child: FoodCard(e)),
                                          ))
                                      .toList(),
                                ),
                              ],
                            )
                          : Center(child: loadingIndicator),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              color: Colors.white,
              child: Column(
                children: [
                  CustomTabBar(
                    titles: const ['New Taste', 'Best Seller', 'Recommended'],
                    selectedIndex: selectedIndex,
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<FoodCubit, FoodState>(builder: (_, state) {
                    if (state is FoodLoaded) {
                      List<Food> foods = state.foods
                          .where((element) =>
                              element.types.contains((selectedIndex == 0)
                                  ? FoodType.newFood
                                  : (selectedIndex == 1)
                                      ? FoodType.popular
                                      : FoodType.recommended))
                          .toList();

                      return Column(
                        children: foods
                            .map((e) => Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      defaultMargin, 0, defaultMargin, 16),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(FoodDetailsPage(
                                        transaction: Transaction(
                                            food: e,
                                            user: (context
                                                    .read<UserCubit>()
                                                    .state as UserLoaded)
                                                .user),
                                        onBackButtonPressed: () {
                                          Get.back();
                                        },
                                      ));
                                    },
                                    child: FoodListItem(
                                        food: e, itemWidth: listItemWidth),
                                  ),
                                ))
                            .toList(),
                      );
                    } else {
                      return Center(
                        child: loadingIndicator,
                      );
                    }
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
