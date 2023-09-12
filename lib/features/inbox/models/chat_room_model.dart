class ChatRoomModel {
  final String roomId;
  final String personAUid;
  final String personBUid;

  ChatRoomModel({
    required this.roomId,
    required this.personAUid,
    required this.personBUid,
  });

  ChatRoomModel.fromJson(Map<String, dynamic> json)
      : personAUid = json['personAUid'],
        roomId = json['roomId'],
        personBUid = json['personBUid'];

  Map<String, dynamic> toJson() {
    return {
      'personAUid': personAUid,
      'personBUid': personBUid,
      "roomId": roomId,
    };
  }
}
