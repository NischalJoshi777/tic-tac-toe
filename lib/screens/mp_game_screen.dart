import 'package:flutter/material.dart';
import 'package:multiplayertictactoe/providers/room_details_provider.dart';
import 'package:provider/provider.dart';

class MultiplayerGameScreen extends StatefulWidget {
  const MultiplayerGameScreen({super.key});

  @override
  State<MultiplayerGameScreen> createState() => _MultiplayerGameScreenState();
}

class _MultiplayerGameScreenState extends State<MultiplayerGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(Provider.of<RoomDetailsProvider>(context).roomData.toString()),
      )
    );
  }
}
