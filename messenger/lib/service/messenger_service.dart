part of '../messenger.dart';

abstract class _MessengerService {
  factory _MessengerService() {
    return _MessengerServiceFirebase();
  }

  Future<Result<Room>> createRoom(
      String firstUserId, String secondUserId);

  Future<Result<Room>> openRoom(String firstUserId, String secondUserId);

  /// Fetch [limit] messages in database, [fromLastDoc] if non-null
  Future<Result<List<Message>>> _fetchMessages(
    Room room,
    int limit,
    PrimitiveWrapper<QueryDocumentSnapshot> lastDoc,
  );

  /// Stream of the last message
  Stream<Message> _incomingMessageStream(Room room);

  /// Save message in the database
  Future<Result> _saveMessage(Room room, Message message);
}
