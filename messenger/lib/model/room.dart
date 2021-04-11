part of '../messenger.dart';

class Room {
  static final String docRefField = 'docRef';
  static final String participantsField = 'participants';
  static final String messageCountField = 'messageCount';
  static final String lastMessageSentTimeField = 'lastMessageSentTime';

  factory Room.fromEntity(Map<String, dynamic> data) {
    return Room(
        docRef: data[docRefField],
        participants: (data[participantsField] as List)?.cast<String>(),
        messageCount: data[messageCountField],
        lastMessageSentTime: data[lastMessageSentTimeField]);
  }

  Room(
      {this.docRef,
      @required this.participants,
      this.messageCount,
      this.lastMessageSentTime});

  final DocumentReference docRef;
  final List<String> participants;
  final int messageCount;
  final Timestamp lastMessageSentTime;

  Map<String, dynamic> toEntity() {
    return {
      docRefField: docRef,
      participantsField: participants,
      messageCountField: messageCount,
      lastMessageSentTimeField: lastMessageSentTime,
    };
  }

  String getOtherUserId(String userId) {
    if (participants[0] == userId)
      return participants[1];
    else
      return participants[0];
  }

  static String getChatRoomId(String firstUserId, String secondUserId) {
    return firstUserId.compareTo(secondUserId) > 0
        ? firstUserId + secondUserId
        : secondUserId + firstUserId;
  }
}
