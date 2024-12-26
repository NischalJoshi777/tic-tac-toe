import 'package:flutter/material.dart';
import 'package:multiplayertictactoe/helper/room_details_provider.dart';
import 'package:multiplayertictactoe/resources/socket_methods.dart';
import 'package:multiplayertictactoe/screens/waiting_lobby.dart';
import 'package:multiplayertictactoe/widgets/mp_tictactoe_board.dart';
import 'package:multiplayertictactoe/widgets/score_board.dart';
import 'package:provider/provider.dart';

class MultiPlayerGameScreen extends StatefulWidget {
  const MultiPlayerGameScreen({super.key});

  @override
  State<MultiPlayerGameScreen> createState() => _MultiPlayerGameScreenState();
}

class _MultiPlayerGameScreenState extends State<MultiPlayerGameScreen> {
  final SocketMethods _methods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _methods.updateRoomListener(context);
    _methods.updatePlayersListener(context);
    _methods.pointIncreaseListener(context);
    _methods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomDetailsProvider>(context);
    return roomProvider.roomData['canJoin']
        ? const WaitingLobby()
        : SafeArea(
            child: Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Scoreboard(),
                  const Expanded(
                    flex: 2,
                    child: MultiplayerTicTacToeBoard(),
                  ),
                  Text('${roomProvider.roomData['turn']['nickname']}\'s turn'),
                ],
              ),
            ),
          );
  }
}
