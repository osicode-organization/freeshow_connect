import 'package:flutter/cupertino.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:freeshow_connect/src/data/data_sources/http_calls.dart'
    show nextSlide_2;

import '../../../data/data_sources/get_calls.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class BitfocusPage extends StatefulWidget {
  const BitfocusPage({super.key});

  @override
  State<BitfocusPage> createState() => _BitfocusPageState();
}

class _BitfocusPageState extends State<BitfocusPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Bitfocus Companion'),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Move to next slide'),
            CupertinoButton(
              onPressed: () async {
                await nextSlide_2();
              },
              color: CupertinoColors.systemMint,
              child: const Text('Next slide'),
            ),
            GutterExtraLarge(),
            Text('Get shows'),
            CupertinoButton(
              onPressed: () async {
                await getShow();
              },
              color: CupertinoColors.systemIndigo,
              child: const Text('Get shows'),
            ),
            GutterExtraLarge(),
            Text('Get projects'),
            CupertinoButton(
              onPressed: () async {
                await getProjects();
              },
              color: CupertinoColors.systemRed,
              child: const Text('Get projects'),
            ),
          ],
        ),
      ),
    );
  }
}
