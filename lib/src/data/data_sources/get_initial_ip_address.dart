import 'dart:convert';

import 'package:http/http.dart' as http;

const String ipAddressError = 'ERROR';
final String publicIpAddress = '192.168.1.1';

Future<String> getPublicIP() async {
  try {
    final response = await http.get(
      Uri.parse('https://api.ipify.org?format=json'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final String ip = data['ip'];
      return ip;
    } else {
      throw Exception('Failed to load public IP: ${response.statusCode}');
      return ipAddressError;
    }
  } catch (e) {
    throw Exception('Failed to get public IP: $e');
    return ipAddressError;
  }
}
