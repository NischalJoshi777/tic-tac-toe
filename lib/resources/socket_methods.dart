import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:multiplayertictactoe/resources/socket_client.dart';
import 'package:multiplayertictactoe/routes.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../providers/room_details_provider.dart';

class SocketMethods {
  final Socket _client = SocketClient
      .instance.socket!; //Taking the single instance of the socket client.

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

  //LISTENERS
  void createRoomSuccessListener(BuildContext context) {
    _client.on('createRoomSuccess', (room) {
      Navigator.pushNamed(context, RouteName.gameScreen);
      Provider.of<RoomDetailsProvider>(context, listen: false)
          .updateRooData(room);
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

  void Xturn(int index) {}

  void Oturn(int index) {}
}
