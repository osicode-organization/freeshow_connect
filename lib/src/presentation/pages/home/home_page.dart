

import 'package:flutter/cupertino.dart';

import '../../../data/data_sources/http_calls.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*
  FreeShowWebSocketService? _webSocketService;
  String _lastReceivedMessage = 'No messages yet.';
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _webSocketService = FreeShowWebSocketService(
      onMessageReceived: (message) {
        setState(() {
          _lastReceivedMessage = 'Received: $message';
        });
        // You would parse the message here based on FreeShow's WebSocket events
        // e.g., if it sends {"type": "slide_changed", "currentSlide": 5}
      },
      onError: (error) {
        setState(() {
          _lastReceivedMessage = 'Error: $error';
          _isConnected = false;
        });
      },
      onDisconnected: () {
        setState(() {
          _isConnected = false;
          _lastReceivedMessage = 'Disconnected.';
        });
      },
    );
    _webSocketService!.connect(); // Connect when the screen initializes
  }

  @override
  void dispose() {
    _webSocketService?.disconnect(); // Disconnect when the screen is disposed
    super.dispose();
  }

  void _sendNextProjectItem() {
    _webSocketService?.sendMessage('next_project_item');
  }

  void _selectProjectByIndex(int index) {
    _webSocketService?.sendMessage(
      'index_select_project',
      data: {'index': index},
    );
  }*/

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Freeshow connect app'),
        // trailing: Icon(CupertinoIcons.person_crop_circle),
      ),
      child: SafeArea(
        child:
        ListView(
          padding: const EdgeInsets.all(10),
          children: [
            CupertinoButton(
              onPressed: () async {
                await nextSlide();
              },
              child: const Text('Connect socket'),
            ),
            Text('Move to next slide'),
            CupertinoButton(
              onPressed: () async {
                await nextSlide_2();
              },
              child: const Text('Next slide'),
            )
             /*Text(
              'Connection Status: ${_isConnected ? "Connected" : "Disconnected"}',
            ),
            const SizedBox(height: 10),
            Text(_lastReceivedMessage),
            const SizedBox(height: 20),
            CupertinoButton(
              onPressed: () {
                if (_webSocketService == null || !_isConnected) {
                  _webSocketService?.connect();
                } else {
                  _webSocketService?.disconnect();
                }
              },
              child: Text(_isConnected ? 'Disconnect' : 'Connect'),
            ),*/
          ],
        ),
      ),
    );
  }
}
