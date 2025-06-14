import 'package:flutter/cupertino.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freeshow_connect/dependency_injection/dependency_injection.dart';
import 'package:icons_plus/icons_plus.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late TextEditingController _ipController;

  bool ipButtonStatus = false;
  @override
  void initState() {
    super.initState();
    _ipController = TextEditingController(
      text: ref.read(ipAddressProvider).localIP,
    );
  }

  @override
  void dispose() {
    _ipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localIp = ref.watch(ipAddressProvider);

    final asyncPortStatus = ref.watch(portStatusStreamProvider);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Freeshow connect app'),
        trailing:
            localIp.connectionStatus
                ? Icon(
                  HeroIcons.check_circle,
                  color: CupertinoColors.systemGreen,
                )
                : Icon(HeroIcons.x_circle, color: CupertinoColors.systemRed),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GutterExtraLarge(),
                Text(
                  'Ensure that devices  are connected to the  same internet',
                ),
                GutterMedium(),
                /* IP text form*/
                Form(
                  autovalidateMode: AutovalidateMode.always,
                  onChanged: () {
                    Form.maybeOf(primaryFocus!.context!)?.save();
                  },
                  child: CupertinoFormSection.insetGrouped(
                    children: [
                      CupertinoTextFormFieldRow(
                        enabled: ipButtonStatus,
                        controller: _ipController,
                        placeholder: 'Required',
                        prefix: Text(
                          'IP address',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                GutterMedium(),
                /* IP button */
                CupertinoButton(
                  color:
                      ipButtonStatus
                          ? CupertinoColors.systemBlue
                          : CupertinoColors.systemFill,
                  child:
                      ipButtonStatus
                          ? Text(
                            'Activate',
                            style: TextStyle(color: CupertinoColors.white),
                          )
                          : Text(
                            'Deactivate',
                            style: TextStyle(color: CupertinoColors.systemGrey),
                          ),
                  onPressed: () {
                    setState(() {
                      ipButtonStatus = !ipButtonStatus;
                    });
                    if (!ipButtonStatus) {
                      ref.read(ipAddressProvider).setLocalIpAddress =
                          _ipController.text;
                      debugPrint('send ip address');
                    }
                  },
                ),
                GutterExtraLarge(),
                GutterExtraLarge(),
                GutterExtraLarge(),
                GutterExtraLarge(),
                if (asyncPortStatus.hasValue)
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color:
                              asyncPortStatus.value!.isOpen
                                  ? CupertinoColors.activeGreen
                                  : CupertinoColors.systemRed,
                        ),
                        child: Center(
                          child: Text(
                            asyncPortStatus.value!.isOpen
                                ? 'Connected'
                                : 'Disconnected',
                          ),
                        ),
                      ),
                      /*if (asyncPortStatus.value!.responseTime != null)
                        Text(
                          'Response: ${asyncPortStatus.value!.responseTime}ms',
                        ),
                      if (asyncPortStatus.value!.error != null)
                        Text('Error: ${asyncPortStatus.value!.error}'),
                      Text(
                        'Last checked: ${DateFormat('HH:mm:ss').format(asyncPortStatus.value!.lastChecked)}',
                      ),*/
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
