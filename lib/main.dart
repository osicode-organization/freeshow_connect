import 'package:flutter/cupertino.dart';
import 'package:freeshow_connect/src/presentation/pages/home/home_page.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String val = '';
  debugPrint('before ssocket');
  // Dart client
  IO.Socket socket = IO.io('http://192.168.3.246:5506');
  socket.onConnect((_) {
    debugPrint('connect');
    // socket.emit('msg', 'test');
  });
  socket.on('event', (data) => debugPrint(data));
  socket.onDisconnect((_) => debugPrint('disconnect'));
  socket.on('fromServer', (_) => debugPrint('_'));
  debugPrint('after ssocket');

  debugPrint('state  is: ${socket.connected}');
  runApp(const FreeshowConnectApp());
}

class FreeshowConnectApp extends StatelessWidget {
  const FreeshowConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.systemRed,
      ),
      home: const HomePage(),
    );
  }
}
