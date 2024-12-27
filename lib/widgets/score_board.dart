import 'package:flutter/material.dart';
import 'package:multiplayertictactoe/helper/room_details_provider.dart';
import 'package:provider/provider.dart';

class Scoreboard extends StatelessWidget {
  const Scoreboard({super.key});

  @override
  Widget build(BuildContext context) {
    RoomDetailsProvider roomDataProvider =
        Provider.of<RoomDetailsProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                roomDataProvider.player1.nickname,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Text(
                roomDataProvider.player1.points.toInt().toString(),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                roomDataProvider.player2.nickname,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              Text(
                roomDataProvider.player2.points.toInt().toString(),
                style: const TextStyle(
                  fontSize: 28,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
