import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../dependency_injection/dependency_injection.dart';

// final String baseUrl = 'http://localhost:5505';

class LoadSongs extends AsyncNotifier {
  @override
  FutureOr build() {
    // return null;
  }

  Future<void> loadSong(String songId) async {
    final String baseUrl = ref.watch(ipAddressProvider).localIP;
    final response = await http.post(
      Uri.parse('$baseUrl/api/control/loadSong'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'songId': songId}),
    );

    if (response.statusCode == 200) {
      debugPrint('Loaded song with ID: $songId');
    } else {
      throw Exception('Failed to load song');
    }
  }
}

Future<bool> isPortOpen(
  String host,
  int port, {
  Duration timeout = const Duration(seconds: 1),
}) async {
  try {
    final socket = await Socket.connect(host, port, timeout: timeout);
    socket.destroy();
    return true;
  } catch (e) {
    return false;
  }
}

// Usage
