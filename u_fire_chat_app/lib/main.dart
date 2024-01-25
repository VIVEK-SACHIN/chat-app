// import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:u_fire_chat_app/Screens/SpashScreen.dart';
import 'package:u_fire_chat_app/Screens/authScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:u_fire_chat_app/Screens/chatScreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Firebase.initializeApp();
  // await FirebaseAppCheck.instance.activate();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 63, 17, 177)),
      ),
      home: StreamBuilder(
        stream:
            FirebaseAuth.instance.authStateChanges() /*this in the end gives */,
        builder: (context, snapshot) {
          //this  function will be run by flutter when ever this stream emit a new value
          //snapshot gives us access to that emitted value.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashSCreen();
          }
          if (snapshot.hasData) {
            return const ChatScreen();
          }
          return AuthScreen();
        },
      ),
      /*Widget similar to future buld but instead it is used to listen to a Stream
      future will be done once it is resolved on the other hand Stream could provide multiple values over time */
    );
  }
}
