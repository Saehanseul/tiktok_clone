import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/inbox/models/chat_room_model.dart';
import 'package:tiktok_clone/features/inbox/repos/messages_repo.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/repos/users_repos.dart';

class ChatListViewModel extends AsyncNotifier<List<ChatRoomModel>> {
  late final MessagesRepo _repo;
  @override
  FutureOr<List<ChatRoomModel>> build() async {
    _repo = ref.read(messagesRepo);

    final chatList = await _repo.getChatList();

    return chatList;
  }

  // Future<void> getChatList() async {
  //   state = const AsyncValue.loading();
  //   state = await AsyncValue.guard(() async {
  //     await _repo.getChatList();
  //   });
  // }
  FutureOr<UserProfileModel> getChatRoomUser(String uid) async {
    final profile = await ref.read(UserRepo).findProfile(uid);
    if (profile != null) {
      return UserProfileModel.fromJson(profile);
    }
    return UserProfileModel.empty();
  }
}

final chatListProvider =
    AsyncNotifierProvider<ChatListViewModel, List<ChatRoomModel>>(
  () => ChatListViewModel(),
);
