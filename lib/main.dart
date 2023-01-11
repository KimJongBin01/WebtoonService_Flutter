import 'package:flutter/material.dart';
import 'package:toonflix/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: const Color.fromARGB(255, 85, 49, 204),
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Color(0xFFFFFFFF),
          ),
        ),
        cardColor: const Color(0xFF000000),
      ),
      home: const HomeScreen(),
    );
  }
}
