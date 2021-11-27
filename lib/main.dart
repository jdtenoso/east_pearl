import 'package:east_pearl/screens/stats_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:east_pearl/screens/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    EastPearl(),
  );
}

class EastPearl extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  EastPearl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        StatsScreen.id: (context) => const StatsScreen(),
      },
    );
  }
}
