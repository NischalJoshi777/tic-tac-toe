import 'package:flutter/material.dart';
import 'package:multiplayertictactoe/providers/room_details_provider.dart';
import 'package:multiplayertictactoe/routes.dart';
import 'package:multiplayertictactoe/screens/create_room_screen.dart';
import 'package:multiplayertictactoe/screens/join_room_screen.dart';
import 'package:multiplayertictactoe/screens/mp_game_screen.dart';
import 'package:provider/provider.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RoomDetailsProvider(),
      child: MaterialApp(
        title: 'Tic Tac Toe',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color.fromRGBO(16, 13, 34, 1),
        ),
        routes: {
          RouteName.main: (_) => const MainScreen(),
          RouteName.createRoom: (_) => const CreateRoomScreen(),
          RouteName.joinRoom: (_) => const JoinRoomScreen(),
          RouteName.gameScreen: (_) => const MultiplayerGameScreen(),
        },
        initialRoute: RouteName.main,
      ),
    );
  }
}
