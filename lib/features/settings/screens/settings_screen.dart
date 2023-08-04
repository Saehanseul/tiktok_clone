import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/common/widgets/video_config/video_config.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notification = false;

  void _onNotificationsChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notification = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          AnimatedBuilder(
            animation: isDarkMode,
            builder: (context, child) => SwitchListTile.adaptive(
              value: isDarkMode.value,
              onChanged: (value) {
                isDarkMode.value = !isDarkMode.value;
              },
              title: const Text("Dark Mode"),
              subtitle: const Text("Make theme mode dark or light"),
            ),
          ),

          /// 상태관리 방법 4:  Provider
          SwitchListTile.adaptive(
            value: context.watch<VideoConofig>().isMuted,
            onChanged: (value) {
              context.read<VideoConofig>().toggleIsMuted();
            },
            title: const Text("Auto Mute"),
            subtitle: const Text("Video will be muted by default."),
          ),
          /* /// 상태관리 방법 3: ValueNotifier
          ValueListenableBuilder(
            /// ValueListenableBuilder 대신에 위 isDartMode 처럼 AnimatedBuilder 써도 됨
            valueListenable: videoConfig,
            builder: (context, value, child) => SwitchListTile.adaptive(
              value: value,
              onChanged: (value) {
                videoConfig.value = !videoConfig.value;
              },
              title: const Text("Auto Mute"),
              subtitle: const Text("Video will be muted by default."),
            ),
          ), */

          /* /// 상태관리 방법 1: inherited + statefull widgets
          SwitchListTile.adaptive(
            value: VideoConfigData.of(context).autoMute,
            onChanged: (value) {
              VideoConfigData.of(context).toggleMuted();
            },
            title: const Text("Auto Mute"),
            subtitle: const Text("Video will be muted by default."),
          ), */
          CupertinoSwitch(
            value: _notification,
            onChanged: _onNotificationsChanged,
          ),
          Switch.adaptive(
            value: _notification,
            onChanged: _onNotificationsChanged,
          ),
          Switch(
            value: _notification,
            onChanged: _onNotificationsChanged,
          ),
          SwitchListTile(
            title: const Text("switch list tile"),
            value: _notification,
            onChanged: _onNotificationsChanged,
          ),
          SwitchListTile.adaptive(
            title: const Text("switch list tile adaptive"),
            subtitle: const Text("switch list tile adaptive"),
            value: _notification,
            onChanged: _onNotificationsChanged,
          ),
          Checkbox(
            value: _notification,
            onChanged: _onNotificationsChanged,
          ),
          CheckboxListTile(
            checkColor: Colors.black,
            activeColor: Colors.red,
            value: _notification,
            onChanged: _onNotificationsChanged,
            title: const Text("Enable notifications"),
          ),

          ListTile(
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1980),
                lastDate: DateTime(2030),
              );
              if (!mounted) return;
              final time = await showTimePicker(
                  context: context, initialTime: TimeOfDay.now());
              if (kDebugMode) {
                print(date);
              }
              if (kDebugMode) {
                print(time);
              }
              if (!mounted) return;
              final booking = await showDateRangePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime(2030),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData(
                      appBarTheme: const AppBarTheme(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (kDebugMode) {
                print(booking);
              }
            },
            title: const Text("What is your birthday?"),
          ),
          const AboutListTile(),
          ListTile(
            title: const Text('Log out (iOS)'),
            textColor: Colors.red,
            onTap: () => showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text("Are you sure?"),
                content: const Text("Please don't go"),
                actions: [
                  CupertinoDialogAction(
                    child: const Text("No"),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoDialogAction(
                    isDestructiveAction: true,
                    child: const Text("Yes"),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          ),
          // ListTile(
          //   onTap: () => showAboutDialog(
          //       context: context,
          //       applicationVersion: "1.0",
          //       applicationLegalese: "All rights reserved."),
          //   title: const Text(
          //     "About",
          //     style: TextStyle(
          //       fontWeight: FontWeight.w600,
          //     ),
          //   ),
          //   subtitle: const Text("About this app...."),
          // ),
          ListTile(
            title: const Text('Log out (android)'),
            textColor: Colors.red,
            onTap: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Are you sure?"),
                content: const Text("Please don't go"),
                actions: [
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.car),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  TextButton(
                    child: const Text("Yes"),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text('Log out (iOS / Bottom)'),
            textColor: Colors.red,
            onTap: () => showCupertinoModalPopup(
              context: context,
              builder: (context) => CupertinoActionSheet(
                title: const Text("Are you sure?"),
                message: const Text("Please don't gooooooo~~~!"),
                actions: [
                  CupertinoActionSheetAction(
                    isDefaultAction: true,
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Not log out"),
                  ),
                  CupertinoActionSheetAction(
                    isDestructiveAction: true,
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("yea please"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // body: ListWheelScrollView(
      //   useMagnifier: true,
      //   magnification: 1.5,
      //   itemExtent: 200,
      //   diameterRatio: 1,
      //   offAxisFraction: 2,
      //   children: [
      //     for (var x in [1, 2, 132, 2, 3423, 432, 4, 3, 3, 2, 2, 12])
      //       FractionallySizedBox(
      //         widthFactor: 1,
      //         child: Container(
      //           alignment: Alignment.center,
      //           color: Colors.teal,
      //           child: const Text(
      //             "Click me",
      //             style: TextStyle(
      //               fontSize: Sizes.size52,
      //               color: Colors.white,
      //             ),
      //           ),
      //         ),
      //       ),
      //   ],
      // ),
      // body: const Column(
      //   children: [
      //     CupertinoActivityIndicator(
      //       radius: 40,
      //       animating: false,
      //     ),
      //     CircularProgressIndicator(),
      //     CircularProgressIndicator.adaptive(), // ios, android 각 플랫폼에 맞게 보여줌
      //   ],
      // ),
    );
  }
}
