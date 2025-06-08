import 'package:flutter/cupertino.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class BitfocusPage extends StatefulWidget {
  const BitfocusPage({super.key});

  @override
  State<BitfocusPage> createState() => _BitfocusPageState();
}

class _BitfocusPageState extends State<BitfocusPage> {
  // late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // _controller.loadUrl('http://192.168.3.246:8000/tablet');
    // ..loadRequest(Uri.parse('http://192.168.3.246:8000/tablet'));
    // WebViewController()..loadRequest(Uri.parse('https://flutter.dev'));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Bitfocus Companion'),
      ),
      child: SafeArea(
        child: Container()//WebView(initialUrl: 'http://192.168.3.246:8000/tablet',),),
            // WebViewWidget(controller: _controller),
      ),
    );
  }
}
