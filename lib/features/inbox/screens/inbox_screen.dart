import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/screens/activity_screen.dart';
import 'package:tiktok_clone/features/inbox/screens/chats_screen.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});
  void _onDmPressed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ChatsScreen(),
    ));
  }

  void _onActivityTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ActivityScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: Breakpoints.sm,
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Inbox"),
            elevation: 1,
            actions: [
              IconButton(
                onPressed: () => _onDmPressed(context),
                icon: const FaIcon(FontAwesomeIcons.paperPlane),
              ),
            ],
          ),
          body: ListView(
            children: [
              ListTile(
                onTap: () => _onActivityTap(context),
                title: const Text(
                  "Activity",
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const FaIcon(
                  FontAwesomeIcons.chevronRight,
                  color: Colors.black,
                  size: Sizes.size16,
                ),
              ),
              Container(
                height: Sizes.size1,
                color: Colors.grey.shade200,
              ),
              ListTile(
                leading: Container(
                  width: Sizes.size52,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.users,
                      color: Colors.white,
                    ),
                  ),
                ),
                title: const Text(
                  "New followers",
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: const Text(
                  "Messages from followers will appear here",
                  style: TextStyle(
                    fontSize: Sizes.size12,
                  ),
                ),
                trailing: const FaIcon(
                  FontAwesomeIcons.chevronRight,
                  color: Colors.black,
                  size: Sizes.size16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
