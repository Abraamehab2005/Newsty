import 'package:flutter/material.dart';
import 'package:news_app/core/constans/app_size.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';
import 'package:news_app/features/auth/login_screen.dart';
import 'package:news_app/features/main/main_screen.dart';
import 'package:news_app/features/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }

  void _navigateAfterSplash() async {
    await Future.delayed(const Duration(seconds: 2));
    final bool onboardingComplete =
        PreferencesManager().getBool('onboarding_complete') ?? false;
    final bool isLoggedIn =
        PreferencesManager().getBool('is_logged_in') ?? false;
    if (!mounted) return;
    if (!onboardingComplete) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const OnboardingScreen();
          },
        ),
      );
    } else if (!isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const LoginScreen();
          },
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const MainScreen(); // HomeScreen
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/splash.png', width: AppSize.w350, fit: BoxFit.fill,),
      ),
    );
  }
}
