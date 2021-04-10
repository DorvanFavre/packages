part of '../messenger.dart';

class _MessengerServiceFirebase implements _MessengerService {
  final kMessagesCollection = 'Messages';

  @override
  Future<Result<List<Message>>> fetchMessages(Room room, int limit,
      {QueryDocumentSnapshot fromLastDoc}) {
    final query = fromLastDoc != null
        ? room.docRef
            .collection(kMessagesCollection)
            .startAfterDocument(fromLastDoc)
        : room.docRef.collection(kMessagesCollection);

    return query
        .limit(limit)
        .get()
        .then((snap) => Success(
            data: snap.docs
                .map((doc) => Message.fromEntity(doc.data()))
                .toList()) as Result)
        .catchError((e) => Failure(message: e.toString()));
  }

  @override
  Stream<Message> incomingMessageStream(Room room) {
    return room.docRef
        .collection(kMessagesCollection)
        .limit(1)
        .snapshots()
        .map((snap) => Message.fromEntity(snap.docs.first.data()));
  }

  @override
  Future<Result> saveMessage(Room room, Message message) {

    // TODO add docRef to message

    return room.docRef
        .collection(kMessagesCollection)
        .add(message.toEntity())
        .then((docRef) => Success(data: 'Message saved to database') as Result)
        .catchError((e) => Failure(message: e.toString()));
  }
}
