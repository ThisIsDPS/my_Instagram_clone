import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_app_flutter/responsive/responsive_layout.dart';
import 'package:instagram_app_flutter/responsive/web_screen_layout.dart';
import 'package:instagram_app_flutter/screens/login_screen.dart';
import 'package:instagram_app_flutter/screens/signup_screen.dart';
import 'package:instagram_app_flutter/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensuring flutter widgets initialization
  if (kIsWeb) {
    // Web Firebase Setup
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyD6mGr7fNf8W6lLtRpgRvNDRv9tWbhHjeM',
        appId: '1:907841466106:web:6694095a82721d7bb72343',
        messagingSenderId: '907841466106',
        projectId: 'instagram-clone08-9cf6a',
        // added extra 'storageBucket'
        storageBucket: 'instagram-clone08-9cf6a.appspot.com',
      ),
    ); // Initialising Firebase
  } else {
    // For mobile
    await Firebase.initializeApp(); // Initialising Firebase
  }

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
      // home: const Scaffold(
      //   body: ResponsiveLayout(
      //     mobileScreenLayout: MobileScreenLayout(),
      //     webScreenLayout: WebScreenLayout(),
      //   ),
      // ),
      home: SignupScreen(),
    );
  }
}
