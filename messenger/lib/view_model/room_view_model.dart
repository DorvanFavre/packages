part of '../messenger.dart';

/// Private room view model
///
///
abstract class RoomViewModel {
  factory RoomViewModel({
    @required AuthViewModel authViewModel,
    @required Room room,
    RoomOption roomOption,
  }) {
    return _RoomViewModelImpl(
        room: room, roomOption: roomOption, authViewModel: authViewModel);
  }

  /// Open a conversation room
  ///
  /// Create new one if doesn't exist
  static Future<Result<Room>> openPrivateRoom(
      {@required String firstUserId, @required String secondUserId}) {
    return _MessengerService().createPrivateRoom(firstUserId, secondUserId);
  }

  /// Message notifier
  ///
  /// List of messages - get notified when list changes
  ///
  /// New message automaticaly added - call getOldMessage() to get old messages
  ValueNotifier<List<Message>> messagesNotifier;

  /// Get old message
  ///
  /// Call when reaching top of the ListView to get more messages
  Future<Result> fetchMoreMessages();

  /// Send message
  ///
  /// Send the text of the [inputMessageController]
  Future<Result> sendMessage();

  /// Message controller
  ///
  /// The text you are about to send
  TextEditingController inputMessageController;

  /// Stream of infos to help debugging
  Stream<String> infoStream;

  void dispose();
}
