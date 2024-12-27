import 'package:flutter/material.dart';
import 'package:multiplayertictactoe/helper/room_details_provider.dart';
import 'package:multiplayertictactoe/resources/socket_methods.dart';
import 'package:multiplayertictactoe/widgets/app_header_text.dart';
import 'package:provider/provider.dart';

class MultiplayerTicTacToeBoard extends StatefulWidget {
  const MultiplayerTicTacToeBoard({super.key});

  @override
  State<MultiplayerTicTacToeBoard> createState() =>
      _MultiplayerTicTacToeBoardState();
}

class _MultiplayerTicTacToeBoardState extends State<MultiplayerTicTacToeBoard> {
  final SocketMethods _methods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _methods.tappedListener(context);
  }

  void onTapped(int index, RoomDetailsProvider roomDetailProvider) {
    _methods.tapGrid(
      index,
      roomDetailProvider.roomData['_id'],
      roomDetailProvider.displayElements,
    );
  }

  @override
  Widget build(BuildContext context) {
    RoomDetailsProvider roomDetailsProvider =
        Provider.of<RoomDetailsProvider>(context);

    return AbsorbPointer(
      absorbing: roomDetailsProvider.roomData['turn']['socketID'] !=
          _methods.socketClient.id,
      child: GridView.builder(
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => onTapped(index, roomDetailsProvider),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white24, width: 5.0),
              ),
              child: Center(
                child: AppHeaderText(
                  text: roomDetailsProvider.displayElements[index],
                  shadow: [
                    Shadow(
                      blurRadius: 40.0,
                      color: roomDetailsProvider.displayElements[index] == 'O'
                          ? Colors.red
                          : Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
