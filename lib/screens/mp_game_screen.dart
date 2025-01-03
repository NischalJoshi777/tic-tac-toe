import 'package:flutter/material.dart';
import 'package:multiplayertictactoe/helper/room_details_provider.dart';
import 'package:multiplayertictactoe/resources/socket_methods.dart';
import 'package:multiplayertictactoe/screens/waiting_lobby.dart';
import 'package:multiplayertictactoe/widgets/app_header_text.dart';
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
    _methods.updatePlayersStateListener(context);
    _methods.pointIncreaseListener(context);
    _methods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomDetailsProvider>(context);
    return Scaffold(
      body: roomProvider.roomData['canJoin']
          ? const WaitingLobby()
          : SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  const AppHeaderText(text: 'LET\'S PLAY'),
                  _buildTurnText(context, roomProvider),
                  const SizedBox(height: 20.0),
                  const Expanded(
                    flex: 2,
                    child: MultiplayerTicTacToeBoard(),
                  ),
                  const SizedBox(height: 20.0),
                  const Scoreboard(),
                ],
              ),
            ),
    );
  }

  Widget _buildTurnText(
      BuildContext context, RoomDetailsProvider roomProvider) {
    return Text(
      '${roomProvider.roomData['turn']['nickname']}\'s turn',
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        shadows: [
          BoxShadow(
            color: roomProvider.roomData['turn']['playerType'] == 'O'
                ? Colors.red
                : Colors.blue,
            spreadRadius: 40.0,
            blurRadius: 20.0,
          ),
        ],
      ),
    );
  }
}
