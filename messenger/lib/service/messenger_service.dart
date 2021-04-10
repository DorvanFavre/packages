part of '../messenger.dart';

abstract class _MessengerService {
  factory _MessengerService() {
    return _MessengerServiceFirebase();
  }

  Future<Result<Room>> createPrivateRoom();

  /// Fetch [limit] messages in database, [fromLastDoc] if non-null
  Future<Result<List<Message>>> fetchMessages(Room room, int limit,
      {QueryDocumentSnapshot fromLastDoc});

  /// Stream of the last message
  Stream<Message> incomingMessageStream(Room room);

  /// Save message in the database
  Future<Result> saveMessage(Room room, Message message);
}
