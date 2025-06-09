import 'package:flutter/cupertino.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:freeshow_connect/src/domain/entity/port_status_entity.dart';
import 'package:intl/intl.dart';

import '../../../data/data_sources/check_port_status.dart';
import '../../../data/data_sources/http_calls.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool connectionStatus = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Freeshow connect app'),
        trailing:
            connectionStatus
                ? Icon(
                  CupertinoIcons.check_mark_circled_solid,
                  color: CupertinoColors.systemGreen,
                )
                : Icon(
                  CupertinoIcons.xmark_circle_fill,
                  color: CupertinoColors.systemRed,
                ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            CupertinoButton(
              onPressed: () async {
                // await nextSlide();
                final available = await isPortOpen('localhost', 5505);
                print('Port 3000 is ${available ? 'open' : 'closed'}');
              },
              color: CupertinoColors.systemBrown,
              child: const Text('Connect socket'),
            ),
            Gutter(),
            Text('Move to next slide'),
            CupertinoButton(
              onPressed: () async {
                await nextSlide_2();
              },
              color: CupertinoColors.systemMint,
              child: const Text('Next slide'),
            ),
            Gutter(),
            StreamBuilder<PortStatusEntity>(
              stream: checkPortStatus('localhost', 5505),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CupertinoActivityIndicator();
                }

                final status = snapshot.data!;
                // setState(() {});
                status.isOpen
                    ? connectionStatus = true
                    : connectionStatus = false;
                return Column(
                  children: [
                    CupertinoButton(
                      onPressed: () {},
                      color:
                          status.isOpen
                              ? CupertinoColors.activeGreen
                              : CupertinoColors.systemRed,
                      child: Text(status.isOpen ? 'Connected' : 'Disconnected'),
                    ),
                    if (status.responseTime != null)
                      Text('Response: ${status.responseTime}ms'),
                    if (status.error != null) Text('Error: ${status.error}'),
                    Text(
                      'Last checked: ${DateFormat('HH:mm:ss').format(status.lastChecked)}',
                    ),
                  ],
                );
              },
            ),
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
