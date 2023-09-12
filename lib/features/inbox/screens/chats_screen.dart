import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/models/chat_room_model.dart';
import 'package:tiktok_clone/features/inbox/screens/chat_detail_screen.dart';
import 'package:tiktok_clone/features/inbox/view_models/chat_list_view_model.dart';

class ChatsScreen extends ConsumerStatefulWidget {
  static String routeName = "chats";
  static String routeURL = "/chats";
  const ChatsScreen({super.key});

  @override
  ConsumerState<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends ConsumerState<ChatsScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  final List<int> _item = [];

  final Duration _duration = const Duration(
    milliseconds: 500,
  );

  @override
  void initState() {
    super.initState();
    // ref.read(chatListProvider.notifier).getChatList();
  }

  void _addItem() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(
        _item.length,
        duration: _duration,
      );
      _item.add(_item.length);
    }
  }

  void _deleteItem(String index) {
    // if (_key.currentState != null) {
    //   _key.currentState!.removeItem(
    //     index,
    //     (context, animation) => SizeTransition(
    //         sizeFactor: animation,
    //         child: Container(color: Colors.red, child: _makeTile(index))),
    //     duration: _duration,
    //   );
    //   _item.removeAt(index);
    // }
  }

  void _onChatTap(String uid) {
    context.pushNamed(ChatDetailScreen.routeName, pathParameters: {
      "chatId": uid,
    });
  }

  Widget _makeTile(ChatRoomModel room) {
    final uid = room.roomId;
    return ListTile(
      onLongPress: () => _deleteItem(uid),
      onTap: () => _onChatTap(uid),
      leading: const CircleAvatar(
        radius: 30,
        foregroundImage: NetworkImage(
          "https://avatars.githubusercontent.com/u/25199891?v=4",
        ),
        child: Text("31seul"),
      ),
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "31seul ${room.personBUid}",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "2:16 PM",
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: Sizes.size12,
              ),
            ),
          ]),
      subtitle: const Text("hihi ~~~ nice to meet you!"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Direct Messages"),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const FaIcon(
              FontAwesomeIcons.plus,
            ),
          ),
        ],
      ),
      body: ref.watch(chatListProvider).when(
            data: (chatRooms) {
              return AnimatedList(
                initialItemCount: chatRooms.length,
                key: _key,
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size10,
                ),
                itemBuilder: (context, index, animation) {
                  return FadeTransition(
                    key: UniqueKey(),
                    opacity: animation,
                    child: SizeTransition(
                      //ScaleTrasition도 있음
                      sizeFactor: animation,
                      child: _makeTile(chatRooms[index]),
                    ),
                  );
                },
              );
            },
            error: (error, stackTrace) => Center(
              child: Text(
                error.toString(),
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
    );
  }
}
