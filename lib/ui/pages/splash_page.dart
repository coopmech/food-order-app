import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    getInit();

    super.initState();
  }

  getInit() {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) async {
        await Future.delayed(
          const Duration(seconds: 3),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => const OnboardingPage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
}
