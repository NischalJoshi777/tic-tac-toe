import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:multiplayertictactoe/helper/mp_game_helper.dart';
import 'package:multiplayertictactoe/helper/utils.dart';
import 'package:multiplayertictactoe/resources/socket_client.dart';
import 'package:multiplayertictactoe/routes.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../helper/room_details_provider.dart';

class SocketMethods {
  final Socket _client = SocketClient
      .instance.socket!; //Taking the single instance of the socket client.

  Socket get client => _client;
  void createRoom({required String nickname}) {
    try {
      _client.emit('createRoom', {
        'nickname': nickname,
      });
    } catch (e) {
      log(e.toString()); //printing what the exception is
      throw Exception(e.toString());
    }
  }

  //CREATE ROOM SUCCESS LISTENERS
  void createRoomSuccessListener(BuildContext context) {
    _client.on('createRoomSuccess', (room) {
      Provider.of<RoomDetailsProvider>(context, listen: false)
          .updateRooData(room);
      Navigator.pushNamed(context, RouteName.gameScreen);
    });
  }

  //JOIN ROOM SUCESS LISTENERS
  void joinRoomSuccessListener(BuildContext context) {
    _client.on('joinRoomSuccess', (room) {
      Provider.of<RoomDetailsProvider>(context, listen: false)
          .updateRooData(room);
      Navigator.pushNamed(context, RouteName.gameScreen);
    });
  }

  //ERROR LISTENERS
  void errorOccurredListener(BuildContext context) {
    _client.on('errorOccurred', (error) {
      showSnackBar(context, error);
    });
  }

  void updatePlayersListener(BuildContext context) {
    _client.on('updatePlayers', (players) {
      Provider.of<RoomDetailsProvider>(context, listen: false)
          .updatePlayer1Details(players[0]);
      Provider.of<RoomDetailsProvider>(context, listen: false)
          .updatePlayer2Details(players[1]);
    });
  }

  void updateRoomListener(BuildContext context) {
    _client.on('updateRoom', (roomData) {
      Provider.of<RoomDetailsProvider>(context, listen: false)
          .updateRooData(roomData);
    });
  }

  void gridTapped(int index, String roomId, List<String> boardItems) {
    if (boardItems[index] == "") {
      _client.emit('tap', {
        "index": index,
        "roomId": roomId,
      });
    }
  }

  void gridTapListener(BuildContext context) {
    _client.on('tapped', (data) {
      final roomDetailsProvider =
          Provider.of<RoomDetailsProvider>(context, listen: false);
      roomDetailsProvider.updateDisplayElement(
        data['index'],
        data['choice'],
      );
      roomDetailsProvider.updateRooData(data['room']);
      MpGameHelper().checkWinner(context, client);
    });
  }

  void pointIncreaseListener(BuildContext context) {
    _client.on('pointIncrease', (playerData) {
      var roomDetails =
          Provider.of<RoomDetailsProvider>(context, listen: false);
      if (playerData['socketID'] == roomDetails.player1.socketID) {
        roomDetails.updatePlayer1Details(playerData);
      } else {
        roomDetails.updatePlayer2Details(playerData);
      }
    });
  }

  void endGameListener(BuildContext context) {
    client.on('endGame', (playerData) {
      showDialogBox(context, '${playerData['nickname']} won the game!');
      Navigator.popUntil(context, (route) => false);
    });
  }

  void joinRoom({
    required String roomId,
    required String nickname,
  }) {
    try {
      _client.emit('joinRoom', {
        "nickname": nickname,
        "roomId": roomId,
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
