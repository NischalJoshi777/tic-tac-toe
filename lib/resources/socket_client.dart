import "package:multiplayertictactoe/helper/my_ip.dart";
import "package:socket_io_client/socket_io_client.dart" as IO;

class SocketClient {
  IO.Socket? socket;
  static SocketClient? _instance;

  //defining a private named construction
  SocketClient._internal() {
    socket = IO.io(my_ip, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket!.connect();
    socket!.onConnect((_) {
      socket?.emit('msg', 'test');
    });
  }

  static SocketClient get instance => _instance ?? SocketClient._internal();
}
