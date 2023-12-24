import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app_flutter/providers/user_provider.dart';
import 'package:instagram_app_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_app_flutter/responsive/responsive_layout.dart';
import 'package:instagram_app_flutter/responsive/web_screen_layout.dart';
import 'package:instagram_app_flutter/screens/login_screen.dart';
import 'package:instagram_app_flutter/screens/signup_screen.dart';
import 'package:instagram_app_flutter/utils/colors.dart';
import 'package:provider/provider.dart';

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
    // We added this 'MultiProvider' widget after we added 'notifyListners()' line in 'providers/user_provider.dart'
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner:
            false, // Removes debug banner from top-right corner
        title: 'Instagram Clone',
        theme: ThemeData.dark().copyWith(
          // Setting up dark theme with some tweeks we need
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        // {Specificaly using for the case that when the user logins, the state must be presisted}
        // StreamBuilder in Flutter rebuilds its UI in response to events emitted by a stream, allowing dynamic updates based on asynchronous data.
        home: StreamBuilder(
          /* There are 3 methods that firebase provides us to check if the authentication state is there or not :-
          1) FirebaseAuth.instance.idTokenChanges() ~ If you need to monitor changes to the user's ID token specifically
          2) FirebaseAuth.instance.userChanges() ~ If you need detailed user information and want a stream of complete User objects
          3) FirebaseAuth.instance.authStateChanges() ~ If you only need to know whether the user is authenticated or not and don't require detailed user information
          */
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // In streambuilder, We always first check if our connection has been made with the stream
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // If snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            // Means connection to future hasnt been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // If snapshot does not have any data means the user have not been authenticated, so we display Login Screen
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
