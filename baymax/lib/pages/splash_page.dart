import 'package:baymax/core/navigation_functions.dart';
import 'package:baymax/pages/home_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  double height = 0;
  double opacity = 0;
  bool showTitle = false;
  late AnimationController _animationController;
  bool? onBoarding;
  String? cachedUid;

  @override
  void initState() {
    splashAnimationSetup();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 150,
            child: ScaleTransition(
              scale: _animationController,
              child: Hero(
                tag: "logo",
                child: Image.asset(
                  "assets/logo.png",
                  width: 100,
                ),
              ),
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            opacity: opacity,
            child: const Text(''),
            onEnd: () {
              navigateToAndReplace(context, const HomePage());
            },
          )
        ],
      )),
    ));
  }

  void splashAnimationSetup() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1300));
    _animationController.forward();
    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        setState(() {
          opacity = 1;
        });
      }
    });
  }
}
