import 'package:socket_io_client/socket_io_client.dart';

class SocketList {
  static List<Socket> sockets = [];

  static void add(Socket socket) {
    sockets.add(socket);
  }

  static void remove(Socket socket) {
    sockets.remove(socket);
  }

  static void disconnected(String message) {
    for (var socket in sockets) {
      socket.disconnected;
    }
  }
}
