import 'package:flutter/material.dart';
import 'package:multiplayertictactoe/helper/room_details_provider.dart';
import 'package:multiplayertictactoe/resources/socket_methods.dart';
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
    final size = MediaQuery.of(context).size;
    RoomDetailsProvider roomDetailsProvider =
        Provider.of<RoomDetailsProvider>(context);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: size.height * 0.7,
        maxWidth: 500,
      ),
      child: AbsorbPointer(
        absorbing: roomDetailsProvider.roomData['turn']['socketID'] !=
            _methods.socketClient.id,
        child: GridView.builder(
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => onTapped(index, roomDetailsProvider),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white24,
                  ),
                ),
                child: Center(
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      roomDetailsProvider.displayElements[index],
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 60.0,
                          shadows: [
                            Shadow(
                              blurRadius: 40.0,
                              color:
                                  roomDetailsProvider.displayElements[index] ==
                                          'O'
                                      ? Colors.red
                                      : Colors.blue,
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
