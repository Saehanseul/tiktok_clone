import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/inbox/models/chat_room_model.dart';
import 'package:tiktok_clone/features/inbox/models/message_model.dart';

class MessagesRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> sendMessage(
    MessageModel message,
  ) async {
    await _db
        .collection("chat_rooms")
        .doc("wA7CldaCAozULAUXsl1F")
        .collection("texts")
        .add(message.toJson());
  }

  Future<List<ChatRoomModel>> getChatList() async {
    final list = await _db.collection("chat_rooms").get();

    List<ChatRoomModel> chatRoomList = [];
    for (QueryDocumentSnapshot doc in list.docs) {
      final data = doc.data() as Map<String, dynamic>;
      chatRoomList.add(ChatRoomModel(
        roomId: doc.id,
        personAUid: data["personA"],
        personBUid: data["personB"],
      ));
    }

    return chatRoomList;
  }
}

final messagesRepo = Provider((ref) => MessagesRepo());
