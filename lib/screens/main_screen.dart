import 'package:flutter/material.dart';
import 'package:multiplayertictactoe/screens/join_room_screen.dart';
import 'package:multiplayertictactoe/screens/local_room_screen.dart';
import 'package:multiplayertictactoe/widgets/app_button.dart';
import 'package:multiplayertictactoe/widgets/app_header_text.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppHeaderText(text: 'TIC TAC TOE!'),
            const SizedBox(height: 40.0),
            AppButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const JoinRoomScreen(),
                  ),
                );
              },
              text: 'Join Room',
            ),
            const SizedBox(height: 12.0),
            AppButton(onPressed: () {}, text: 'Create Room'),
            const SizedBox(height: 12.0),
            AppButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LocalRoomScreen(),
                    ),
                  );
                },
                text: 'Play Local')
          ],
        ),
      ),
    );
  }
}
