import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart';

final String baseUrl = 'http://192.168.3.246:5505'; //'http://10.0.2.2:5505';
// 'http://192.168.3.246:3000'; // Replace with your FreeShow API URL
// 'http://127.0.0.1:5505'

Future<void> nextSlide() async {
  // final Map<String, dynamic> data = {};
  //
  // final String actionId = 'next_slide';
  // final String nextUrl = '$baseUrl?action=$actionId&data=${jsonEncode(data)}';

  // var body = jsonEncode({'action': actionId, ...data});
  final uri = Uri.parse('http://192.168.3.246:3000');
  final response = await http.get(
    uri,
    // headers: <String, String>{
    //   'Content-Type': 'application/json; charset=UTF-8',
    // },
    // body: body, //data != null ? jsonEncode(data) : null,
  ); // Encode data to JSON if provided);

  if (response.statusCode == 200) {
    debugPrint(
      'Successfully sent actionId command. Response is ${response.body}',
    );
  } else {
    debugPrint(
      'Failed to send actionId command. Status code: ${response.statusCode}',
    );
    throw Exception('Failed to move to next slide');
  }
}

Future<void> nextSlide_2() async {
  final Map<String, dynamic> data = {};
  //
  final String actionId = 'next_slide';
  final String nextUrl = '$baseUrl?action=$actionId&data=${jsonEncode(data)}';
  // debugPrint('test');

  // var body = jsonEncode({'action': actionId, ...data});
  final uri = Uri.parse(nextUrl); //baseUrl
  final response = await http.post(
    uri,
    // headers: <String, String>{
    //   'Content-Type': 'application/json; charset=UTF-8',
    // },
    // body: body, //data != null ? jsonEncode(data) : null,
  ); // Encode data to JSON if provided);

  if (response.statusCode == 200) {
    debugPrint(
      'Successfully sent actionId command. Response is ${response.body}',
    );
  } else if (response.statusCode == 204) {
    // Handle success with no content
    debugPrint('POST was successful, no content returned.');
  } else {
    debugPrint(
      'Failed to send actionId command. Status code: ${response.statusCode}',
    );
    throw Exception('Failed to move to next slide');
  }
}

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

Future<void> socketConnect() async {
  debugPrint('before ssocket');

  // Dart client
  // Socket socket = io('https://flutter.dev'); //http://192.168.3.246:5505
  Socket socket = io(
    'http://10.0.2.2:5505',
    OptionBuilder()
        .setTransports(['websocket']) // for Flutter or Dart VM
        .disableAutoConnect() // disable auto-connection
        .setExtraHeaders({'foo': 'bar'}) // optional
        .build(),
  );
  socket.connect();

  socket.onConnect((_) {
    debugPrint('connect');
    socket.emit('msg', 'test');
  });
  socket.on('event', (data) => debugPrint('data is: $data'));
  socket.onDisconnect((_) => debugPrint('disconnect'));
  socket.on("error", (err) => debugPrint('Error message from server: $err'));
  socket.on('fromServer', (_) => debugPrint('_'));

  debugPrint('after ssocket');

  debugPrint('state  is: ${socket.connected}');
}
