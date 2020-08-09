import 'package:flutter/material.dart';
import 'package:project_fin_etude/pages/authentification/login.dart';
import 'package:sk_onboarding_screen/flutter_onboarding.dart';
import 'package:sk_onboarding_screen/sk_onboarding_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OnBoardingScreenState();
  }
}

class OnBoardingScreenState extends State<OnBoardingScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _globalKey,
      body: SKOnboardingScreen(
        bgColor: Colors.white,
        themeColor: const Color(0xFFf74269),
        pages: pages,
        skipClicked: (value) {
          print(value);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LoginPage(),
          ));
        },
        getStartedClicked: (value) {
          print(value);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LoginPage(),
          ));
        },
      ),
    );
  }

  final pages = [
    SkOnboardingModel(
        title: 'Choose your item',
        description:
            'Easily find your grocery items and you will get delivery in wide range',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'images/onboarding1.png'),
    SkOnboardingModel(
        title: 'Pick Up or Delivery',
        description: 'We make ordering fast, simple and free-no matter ',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'images/onboarding2.png'),
    SkOnboardingModel(
        title: 'Pay quick and easy',
        description: 'Pay for order using credit or debit card',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'images/onboarding3.png'),
  ];
}
