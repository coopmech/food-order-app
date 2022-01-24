import 'package:flutter/material.dart';
import 'package:food_order/shared/shared.dart';
import 'package:food_order/ui/pages/pages.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: IntroductionScreen(
          dotsDecorator: DotsDecorator(
              color: greyColor,
              activeColor: mainColor,
              size: const Size.square(10.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25))),
          showSkipButton: true,
          skip: Text(
            "Skip",
            style: blackFontStyle2.copyWith(color: secondaryColor),
          ),
          showNextButton: false,
          onSkip: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (c) => const SignInPage(),
                ),
                (route) => false);
          },
          showDoneButton: true,
          doneColor: mainColor,
          onDone: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (c) => const SignInPage(),
                ),
                (route) => false);
          },
          done:
              const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
          pages: [
            PageViewModel(
              titleWidget: Text(
                'CHOOSE YOUR MEAL',
                style: blackFontStyle1.copyWith(
                    color: secondaryColor, fontWeight: FontWeight.bold),
              ),
              bodyWidget: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                style: greyFontStyle,
                textAlign: TextAlign.center,
              ),
              image: Center(
                child: Image.asset("assets/food_wishes.png", height: 250.0),
              ),
            ),
            PageViewModel(
              titleWidget: Text(
                'CHOOSE YOUR PAYMENT',
                style: blackFontStyle1.copyWith(
                    color: secondaryColor, fontWeight: FontWeight.bold),
              ),
              bodyWidget: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                style: greyFontStyle,
                textAlign: TextAlign.center,
              ),
              image: Center(
                child: Image.asset("assets/love_burger.png", height: 250.0),
              ),
            ),
            PageViewModel(
              titleWidget: Text(
                'FAST DELIVERY',
                style: blackFontStyle1.copyWith(
                    color: secondaryColor, fontWeight: FontWeight.bold),
              ),
              bodyWidget: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                style: greyFontStyle,
                textAlign: TextAlign.center,
              ),
              image: Center(
                child: Image.asset("assets/bike.png", height: 250.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
