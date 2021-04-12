part of '../messenger.dart';

class _MessengerServiceFirebase implements _MessengerService {
  final kMessagesCollection = 'Messages';
  final kRoomsCollection = 'Rooms';

  @override
  Future<Result<Room>> createRoom(
      String firstUserId, String secondUserId) {
    final roomId = Room.getChatRoomId(firstUserId, secondUserId);
    final docRef =
        FirebaseFirestore.instance.collection(kRoomsCollection).doc(roomId);

    final room =
        Room(participants: [firstUserId, secondUserId], docRef: docRef);

    return docRef.get().then((snap) {
      if (snap.exists) {
        return Failure(message: 'Room already exists');
      } else {
        return docRef
            .set(room.toEntity())
            .then((value) => Success(data: room) as Result<Room>)
            .catchError((e) => Failure<Room>(message: e.toString()));
      }
    });
  }

  @override
  Future<Result<Room>> openRoom(
      String firstUserId, String secondUserId) {
    final roomId = Room.getChatRoomId(firstUserId, secondUserId);
    final docRef =
        FirebaseFirestore.instance.collection(kRoomsCollection).doc(roomId);

    return docRef.get().then((snap) {
      if (snap.exists) {
        final data = snap.data()..addAll({Room.docRefField: snap.reference});
        return Future.value(
            Success(data: Room.fromEntity(data)) as Result<Room>);
      } else {
        return createRoom(firstUserId, secondUserId);
      }
    }).catchError((e) => Failure<Room>(message: e.toString()));
  }

  @override
  Future<Result<List<Message>>> _fetchMessages(
      Room room, int limit, PrimitiveWrapper<QueryDocumentSnapshot> lastDoc) {
    final query = lastDoc.value != null
        ? room.docRef
            .collection(kMessagesCollection)
            .startAfterDocument(lastDoc.value)
        : room.docRef.collection(kMessagesCollection);

    return query.limit(limit).get().then((snap) {
      lastDoc.value = snap.docs.last;
      return Success(
          data: snap.docs.map((doc) {
        final data = doc.data()..addAll({Message.docRefField: doc.reference});
        return Message.fromEntity(data);
      }).toList()) as Result<List<Message>>;
    }).catchError((e) => Failure<List<Message>>(message: e.toString()));
  }

  @override
  Stream<Message> _incomingMessageStream(Room room) {
    return room.docRef
        .collection(kMessagesCollection)
        .limit(1)
        .snapshots()
        .where((snap) => snap.docChanges.last.type == DocumentChangeType.added)
        .map((snap) {
      final data = snap.docs.last.data()
        ..addAll({Message.docRefField: snap.docs.last.reference});
      return Message.fromEntity(data);
    });
  }

  @override
  Future<Result> _saveMessage(Room room, Message message) {
    final documentId =
        (10000000000000 - DateTime.now().millisecondsSinceEpoch).toString();

    return room.docRef
        .collection(kMessagesCollection)
        .doc(documentId)
        .set(message.toEntity())
        .then((docRef) => Success(data: 'Message saved to database') as Result)
        .catchError((e) => Failure(message: e.toString()));
  }
}
