import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';
import 'package:news_app/core/theme/light_theme.dart';
import 'package:news_app/features/home/home_screen.dart';
import 'package:news_app/features/main/main_screen.dart';
import 'package:news_app/features/onboarding/onboarding_screen.dart';
import 'package:news_app/features/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesManager().init();
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: SplashScreen(),
    );
  }
}
