part of '../messenger.dart';

class _MessengerServiceFirebase implements MessengerService {
  final kMessagesCollection = 'Messages';
  final kRoomsCollection = 'Rooms';

  @override
  Future<Result<Room>> createPrivateRoom(
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
  Future<Result<Room>> openPrivateRoom(
      String firstUserId, String secondUserId) {
    final roomId = Room.getChatRoomId(firstUserId, secondUserId);
    final docRef =
        FirebaseFirestore.instance.collection(kRoomsCollection).doc(roomId);

    return docRef.get().then((snap) {
      if (snap.exists) {
        return Success(
            data: Room.fromEntity(
                snap.data()..addAll({Room.docRefField: snap.reference})));
      } else {
        return createPrivateRoom(firstUserId, secondUserId);
      }
    }).catchError((e) => Failure<Room>(message: e.toString()));
  }

  @override
  Future<Result<List<Message>>> _fetchMessages(Room room, int limit,
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
                .map((doc) => Message.fromEntity(
                    doc.data()..addAll({Message.docRefField: doc.reference})))
                .toList()) as Result)
        .catchError((e) => Failure(message: e.toString()));
  }

  @override
  Stream<Message> _incomingMessageStream(Room room) {
    return room.docRef.collection(kMessagesCollection).limit(1).snapshots().map(
        (snap) => Message.fromEntity(snap.docs.first.data()
          ..addAll({Message.docRefField: snap.docs.first.reference})));
  }

  @override
  Future<Result> _saveMessage(Room room, Message message) {
    return room.docRef
        .collection(kMessagesCollection)
        .add(message.toEntity())
        .then((docRef) => Success(data: 'Message saved to database') as Result)
        .catchError((e) => Failure(message: e.toString()));
  }
}
