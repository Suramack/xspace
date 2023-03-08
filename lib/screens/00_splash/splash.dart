import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:xspace/resources/lottie_file.dart';
import 'package:xspace/routes/routes.dart';
import 'package:xspace/utils/utils.dart';

/// [SplashScreen] is the initial screen that loads into the app.
/// This screen will check whether the User is logged in already.
/// [SplashScreen] will allow the user to land on walkthrough screen if the users for the first time
/// If already installed and already logged in then user will be navigated to dashboard else login

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    inIt();
  }

  Future<void> inIt() async {
    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacementNamed(
        context,
        Routes.getStartedScreen,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: LottieBuilder.asset(
                  LottieFiles.splash,
                  height: Utils.screenSize(context).width * 0.8,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: LottieBuilder.asset(
                LottieFiles.loading,
                width: 150,
              ),
            ),
          )
        ],
      ),
    );
  }
}
