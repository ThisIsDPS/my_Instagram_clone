import 'package:flutter/material.dart';
import 'package:instagram_app_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_app_flutter/responsive/responsive_layout.dart';
import 'package:instagram_app_flutter/responsive/web_screen_layout.dart';
import 'package:instagram_app_flutter/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // Removes debug banner from top-right corner
      title: 'Instagram Clone',
      theme: ThemeData.dark().copyWith(
        // Setting up dark theme with some tweeks we need
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      home: const Scaffold(
        body: ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout(),
        ),
      ),
    );
  }
}
