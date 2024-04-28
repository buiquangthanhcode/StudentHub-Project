// ignore: library_prefixes
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/utils/logger.dart';

class SocketService {
  late IO.Socket _socket;

  void initSocket(BuildContext context, String projectId) {
    _socket = IO.io(
        "https://api.studenthub.dev",
        OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());

    _socket.io.options?['extraHeaders'] = {
      'Authorization':
          'Bearer ${context.read<AuthBloc>().state.userModel.token!}',
    };
    _socket.io.options?['query'] = {'project_id': projectId};

    _socket.connect();

    // ignore: avoid_print
    _socket.onConnectError((data) => logger.d('SOCKET ON CONNECT ERROR: $data'));
    // ignore: avoid_print
    _socket.onError((data) => print('SOCKET ON ERROR $data'));
    // ignore: avoid_print
    _socket.on("ERROR", (data) => print('SOCKET ERROR $data'));

    _socket.onConnect((data) => {
          logger.d('Connected'),
        });
  }

  void subscribe(String event, dynamic Function(dynamic) callback) {
    _socket.on(event, callback);
  }

  void receiveMessage(dynamic Function(dynamic) callback) {
    _socket.on('RECEIVE_MESSAGE', callback);
  }

  void sendMessage(dynamic message) {
    _socket.emit('SEND_MESSAGE', message);
  }

  void disconnect() {
    _socket.disconnect();
  }
}
