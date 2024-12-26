import 'package:flutter/material.dart';
import 'package:multiplayertictactoe/providers/room_details_provider.dart';
import 'package:multiplayertictactoe/resources/socket_methods.dart';
import 'package:multiplayertictactoe/screens/waiting_lobby.dart';
import 'package:provider/provider.dart';

class MultiplayerGameScreen extends StatefulWidget {
  const MultiplayerGameScreen({super.key});

  @override
  State<MultiplayerGameScreen> createState() => _MultiplayerGameScreenState();
}

class _MultiplayerGameScreenState extends State<MultiplayerGameScreen> {
  final SocketMethods _methods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _methods.updateRoomListener(context);
    _methods.updatePlayersListener(context);
  }

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomDetailsProvider>(context);
    return roomProvider.roomData['canJoin']
        ? const WaitingLobby()
        : const Scaffold(
            body: Column(
              children: [],
            ),
          );
  }
}
