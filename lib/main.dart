import 'package:flutter/material.dart';
import 'package:product_management/common/theme/theme.dart';
import 'package:product_management/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightThemeMode,
      home: const SplashScreen(),
    );
  }
}
