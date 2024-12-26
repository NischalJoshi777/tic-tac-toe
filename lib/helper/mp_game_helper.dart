import 'package:flutter/material.dart';
import 'package:multiplayertictactoe/helper/room_details_provider.dart';
import 'package:multiplayertictactoe/helper/utils.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class MpGameHelper {
  void checkWinner(BuildContext context, Socket client) {
    RoomDetailsProvider roomDetailsProvider =
        Provider.of<RoomDetailsProvider>(context, listen: false);

    String winner = "";

    // Checking rows
    if (roomDetailsProvider.displayElements[0] ==
            roomDetailsProvider.displayElements[1] &&
        roomDetailsProvider.displayElements[0] ==
            roomDetailsProvider.displayElements[2] &&
        roomDetailsProvider.displayElements[0] != '') {
      winner = roomDetailsProvider.displayElements[0];
    }
    if (roomDetailsProvider.displayElements[3] ==
            roomDetailsProvider.displayElements[4] &&
        roomDetailsProvider.displayElements[3] ==
            roomDetailsProvider.displayElements[5] &&
        roomDetailsProvider.displayElements[3] != '') {
      winner = roomDetailsProvider.displayElements[3];
    }
    if (roomDetailsProvider.displayElements[6] ==
            roomDetailsProvider.displayElements[7] &&
        roomDetailsProvider.displayElements[6] ==
            roomDetailsProvider.displayElements[8] &&
        roomDetailsProvider.displayElements[6] != '') {
      winner = roomDetailsProvider.displayElements[6];
    }

    // Checking Column
    if (roomDetailsProvider.displayElements[0] ==
            roomDetailsProvider.displayElements[3] &&
        roomDetailsProvider.displayElements[0] ==
            roomDetailsProvider.displayElements[6] &&
        roomDetailsProvider.displayElements[0] != '') {
      winner = roomDetailsProvider.displayElements[0];
    }
    if (roomDetailsProvider.displayElements[1] ==
            roomDetailsProvider.displayElements[4] &&
        roomDetailsProvider.displayElements[1] ==
            roomDetailsProvider.displayElements[7] &&
        roomDetailsProvider.displayElements[1] != '') {
      winner = roomDetailsProvider.displayElements[1];
    }
    if (roomDetailsProvider.displayElements[2] ==
            roomDetailsProvider.displayElements[5] &&
        roomDetailsProvider.displayElements[2] ==
            roomDetailsProvider.displayElements[8] &&
        roomDetailsProvider.displayElements[2] != '') {
      winner = roomDetailsProvider.displayElements[2];
    }

    // Checking Diagonal
    if (roomDetailsProvider.displayElements[0] ==
            roomDetailsProvider.displayElements[4] &&
        roomDetailsProvider.displayElements[0] ==
            roomDetailsProvider.displayElements[8] &&
        roomDetailsProvider.displayElements[0] != '') {
      winner = roomDetailsProvider.displayElements[0];
    }
    if (roomDetailsProvider.displayElements[2] ==
            roomDetailsProvider.displayElements[4] &&
        roomDetailsProvider.displayElements[2] ==
            roomDetailsProvider.displayElements[6] &&
        roomDetailsProvider.displayElements[2] != '') {
      winner = roomDetailsProvider.displayElements[2];
    } else if (roomDetailsProvider.filledBoxes == 9) {
      winner = '';
      showDialogBox(context, 'It is a draw');
    }

    if (winner != "") {
      if (roomDetailsProvider.player1.playerType == winner) {
        showDialogBox(context, '${roomDetailsProvider.player1.nickname} won!');
        client.emit('winner', {
          'winnerSocketId': roomDetailsProvider.player1.socketID,
          'roomID': roomDetailsProvider.roomData['_id'],
        });
      } else {
        showDialogBox(context, '${roomDetailsProvider.player2.nickname} won!');
        client.emit('winner', {
          'winnerSocketId': roomDetailsProvider.player2.socketID,
          'roomID': roomDetailsProvider.roomData['_id'],
        });
      }
    }
  }

  void clearBoard(BuildContext context) {
    RoomDetailsProvider roomDetailsProvider =
        Provider.of<RoomDetailsProvider>(context, listen: false);
    for (int i = 0; i < roomDetailsProvider.displayElements.length; i++) {
      roomDetailsProvider.updateDisplayElement(i, '');
      roomDetailsProvider.setFilledBoxValue(0);
    }
  }
}
