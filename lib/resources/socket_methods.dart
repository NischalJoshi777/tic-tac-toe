import 'dart:developer';

import 'package:multiplayertictactoe/resources/socket_resource.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketMethods {
  final Socket _client = SocketClient.instance.socket!;

  ///these are game methods
  ///method to create Rooms
  void createRoom({required String nickname}) {
    try {
      _client.emit('createRoom', {
        "nickname": nickname,
      });
    } catch (e) {
      log(e.toString());
    }
  }

  ///method.to join room
  void joinRoom({required nickname, required String roomId}) {
    _client.emit('joinRoom', {
      "nickname": nickname,
      'roomId': roomId,
    });
  }
}
