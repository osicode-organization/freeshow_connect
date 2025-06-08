import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

final String baseUrl =
    'http://192.168.3.246:5505'; // Replace with your FreeShow API URL

Future<void> nextSlide() async {
  final Map<String, dynamic>? data = null;

  final String actionId = 'next_slide';
  final uri = Uri.parse('$baseUrl/$actionId');
  final response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: data != null ? jsonEncode(data) : null,
  ); // Encode data to JSON if provided);

  if (response.statusCode == 200) {
    debugPrint('Successfully sent $actionId command.');
  } else {
    debugPrint(
      'Failed to send $actionId command. Status code: ${response.statusCode}',
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
  final response = await http.get(Uri.parse('$baseUrl/show_name'));

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON.
    List<dynamic> songs = jsonDecode(response.body);
    debugPrint('songs ARE $songs');
  } else {
    debugPrint('Status code: ${response.statusCode}');
    throw Exception('Failed to load songs');
  }
}
