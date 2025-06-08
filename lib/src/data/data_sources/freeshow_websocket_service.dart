import 'dart:convert'; // For jsonEncode and jsonDecode

import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// Replace with the actual IP and port of your FreeShow application's WebSocket
// Remember to use 'ws://' for unencrypted WebSockets, or 'wss://' for secure ones
const String freeShowWebSocketUrl = 'ws://192.168.3.246:5505';

class FreeShowWebSocketService {
  WebSocketChannel? _channel;
  final Function(dynamic) onMessageReceived; // Callback for incoming messages
  final Function(dynamic)? onError; // Callback for errors
  final Function()? onDisconnected; // Callback for disconnection

  FreeShowWebSocketService({
    required this.onMessageReceived,
    this.onError,
    this.onDisconnected,
  });

  void connect() {
    try {
      _channel = WebSocketChannel.connect(Uri.parse(freeShowWebSocketUrl));
      debugPrint('Attempting to connect to WebSocket: $freeShowWebSocketUrl');

      // Listen for messages from the WebSocket
      _channel!.stream.listen(
        (message) {
          print('Received message: $message');
          onMessageReceived(message);
        },
        onError: (error) {
          print('WebSocket error: $error');
          if (onError != null) onError!(error);
          _reconnect(); // Attempt to reconnect on error
        },
        onDone: () {
          print('WebSocket disconnected.');
          if (onDisconnected != null) onDisconnected!();
          _reconnect(); // Attempt to reconnect on disconnection
        },
        cancelOnError: true, // Cancel subscription on first error
      );
    } catch (e) {
      print('Error connecting to WebSocket: $e');
      if (onError != null) onError!(e);
      _reconnect(); // Attempt to reconnect on connection error
    }
  }

  void sendMessage(String actionId, {Map<String, dynamic>? data}) {
    if (_channel?.sink != null) {
      // The FreeShow API describes actions as part of the path for HTTP POST.
      // For WebSocket, you'll need to confirm with the FreeShow documentation
      // or experiment how commands are sent.
      // A common pattern is to send JSON objects with "action" and "data" fields.
      // Let's assume a structure like: {"action": "action_id", "data": {...}}
      final message = {'action': actionId, if (data != null) 'data': data};
      _channel!.sink.add(jsonEncode(message));
      print('Sent WebSocket message: ${jsonEncode(message)}');
    } else {
      print('WebSocket not connected. Cannot send message: $actionId');
    }
  }

  void disconnect() {
    _channel?.sink.close();
    _channel = null;
    print('WebSocket manually disconnected.');
  }

  // Basic reconnection logic (can be more sophisticated)
  void _reconnect() {
    print('Attempting to reconnect in 5 seconds...');
    Future.delayed(const Duration(seconds: 5), () {
      if (_channel == null || _channel!.sink.done != null) {
        // Check if already closing/closed
        connect();
      }
    });
  }
}
