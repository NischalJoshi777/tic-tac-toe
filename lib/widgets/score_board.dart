import 'package:flutter/material.dart';
import 'package:multiplayertictactoe/helper/room_details_provider.dart';
import 'package:multiplayertictactoe/widgets/app_header_text.dart';
import 'package:provider/provider.dart';

class Scoreboard extends StatelessWidget {
  const Scoreboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RoomDetailsProvider roomDataProvider =
        Provider.of<RoomDetailsProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppHeaderText(
                text: roomDataProvider.player1.nickname,
              ),
              Text(
                roomDataProvider.player1.points.toInt().toString(),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppHeaderText(
                text: roomDataProvider.player2.nickname,
                shadow: const [
                  BoxShadow(
                    color: Colors.red,
                    spreadRadius: 40.0,
                    blurRadius: 20.0,
                  ),
                ],
              ),
              Text(
                roomDataProvider.player2.points.toInt().toString(),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
