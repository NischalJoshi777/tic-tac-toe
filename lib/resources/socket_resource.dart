import 'package:multiplayertictactoe/my_ip.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketClient {
  io.Socket? socket;
  static SocketClient? _instance;

  get uri => "$my_ip:3000";

  //making singleton
  SocketClient._internal() {
    socket = io.io(uri, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.connect();
  }

  ///creating a singleton
  ///if an instance exists then we return existing instance
  ///if not we create a instance using private named constructor.
  static SocketClient get instance => _instance ??= SocketClient._internal();
}
