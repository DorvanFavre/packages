part of '../messenger.dart';

/// Message
///
///
class Message {
  static final String docRefField = 'docRef';
  static final String senderIdField = 'senderId';
  static final String contentTypeField = 'contentType';
  static final String contentField = 'content';
  static final String sentTimeField = 'sentTime';
  static final String seenByField = 'seenBy';

  static final List<String> contentTypes = ['text', 'image'];

  factory Message.fromEntity(Map<String, dynamic> data) {
    return Message(
      docRef: data[docRefField],
      senderId: data[senderIdField],
      content: data[contentField],
      contentType: data[contentTypeField],
      sentTime: data[sentTimeField],
      seenBy: (data[seenByField] as List)?.cast<String>(),
    );
  }

  Message(
      {this.docRef,
      @required this.senderId,
      @required this.content,
      @required this.sentTime,
      @required this.contentType,
      this.seenBy});

  final DocumentReference docRef;
  final String senderId;
  final String content;
  final String contentType;
  final Timestamp sentTime;
  final List<String> seenBy;

  Map<String, dynamic> toEntity() {
    return {
      docRefField: docRef,
      senderIdField: senderId,
      contentField: content,
      contentTypeField: contentType,
      sentTimeField: sentTime,
    };
  }

  bool operator ==(o) => o is Message && o.docRef == docRef;
}
