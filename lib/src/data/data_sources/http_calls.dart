import 'dart:convert';
// import 'package:socket_io_client/socket_io_client.dart';

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

final String baseUrl = 'http://localhost:5505'; //'http://10.0.2.2:5505';172.31.99.26
// 'http://192.168.3.246:3000'; // Replace with your FreeShow API URL
// 'http://127.0.0.1:5505'

Future<void> loadSong(String songId) async {
  // final String baseUrl = 'http://localhost:5505';
  final response = await http.post(
    Uri.parse('$baseUrl/api/control/loadSong'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'songId': songId}),
  );

  if (response.statusCode == 200) {
    print('Loaded song with ID: $songId');
  } else {
    throw Exception('Failed to load song');
  }
}

Future<void> getSongs() async {
  // final String baseUrl = 'http://localhost:8080'; // Replace with your FreeShow API URL
  String action = 'show_name';
  final response = await http.get(Uri.parse('$baseUrl'));
  debugPrint('statusCode ${response.statusCode}');

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON.
    // List<dynamic> songs = jsonDecode(response.body);
    debugPrint('songs ARE ${response.body}');
  } else {
    debugPrint('Status code: ${response.statusCode}');
    throw Exception('Failed to load songs');
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
