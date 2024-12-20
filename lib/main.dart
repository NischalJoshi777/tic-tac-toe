import 'package:flutter/material.dart';
import 'package:multiplayertictactoe/routes.dart';

import 'screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromRGBO(16, 13, 34, 1),
      ),
      routes: {
        RouteName.main: (_) => const MainScreen(),
      },
      initialRoute: RouteName.main,
    );
  }
}
