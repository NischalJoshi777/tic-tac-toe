import 'package:flutter/material.dart';
import 'package:multiplayertictactoe/helper/mp_game_helper.dart';
import 'package:multiplayertictactoe/helper/room_details_provider.dart';
import 'package:multiplayertictactoe/helper/utils.dart';
import 'package:multiplayertictactoe/resources/socket_client.dart';
import 'package:multiplayertictactoe/routes.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;

  // EMITS
  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'nickname': nickname,
      });
    }
  }

  void joinRoom(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'nickname': nickname,
        'roomId': roomId,
      });
    }
  }

  void tapGrid(int index, String roomId, List<String> displayElements) {
    if (displayElements[index] == '') {
      _socketClient.emit('tap', {
        'index': index,
        'roomId': roomId,
      });
    }
  }

  // LISTENERS
  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on('createRoomSuccess', (room) {
      Provider.of<RoomDetailsProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, RouteName.gameScreen);
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on('joinRoomSuccess', (room) {
      Provider.of<RoomDetailsProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, RouteName.gameScreen);
    });
  }

  void errorOccuredListener(BuildContext context) {
    _socketClient.on('errorOccurred', (data) {
      showSnackBar(context, data);
    });
  }

  void updatePlayersStateListener(BuildContext context) {
    _socketClient.on('updatePlayers', (playerData) {
      Provider.of<RoomDetailsProvider>(context, listen: false).updatePlayer1(
        playerData[0],
      );
      Provider.of<RoomDetailsProvider>(context, listen: false).updatePlayer2(
        playerData[1],
      );
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on('updateRoom', (data) {
      Provider.of<RoomDetailsProvider>(context, listen: false)
          .updateRoomData(data);
    });
  }

  void tappedListener(BuildContext context) {
    _socketClient.on('tapped', (data) {
      RoomDetailsProvider roomDataProvider =
          Provider.of<RoomDetailsProvider>(context, listen: false);
      roomDataProvider.updateDisplayElements(
        data['index'],
        data['choice'],
      );
      roomDataProvider.updateRoomData(data['room']);
      // check winnner
      MpGameHelper().checkWinner(context, _socketClient);
    });
  }

  void pointIncreaseListener(BuildContext context) {
    _socketClient.on('pointIncrease', (playerData) {
      var roomDataProvider =
          Provider.of<RoomDetailsProvider>(context, listen: false);
      if (playerData['socketID'] == roomDataProvider.player1.socketID) {
        roomDataProvider.updatePlayer1(playerData);
      } else {
        roomDataProvider.updatePlayer2(playerData);
      }
    });
  }

  void endGameListener(BuildContext context) {
    _socketClient.on('endGame', (playerData) {
      showDialogBox(context, '${playerData['nickname']} won the game!');
      Navigator.popUntil(context, (route) => false);
    });
  }
}
