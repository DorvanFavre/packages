part of '../messenger.dart';

/// Private room view model
///
///
abstract class PrivateRoomViewModel {
  factory PrivateRoomViewModel({
    @required AuthViewModel authViewModel,
    @required Room room,
    RoomOption roomOption,
  }) {
    return _PrivateRoomViewModelImpl(
        room: room, roomOption: roomOption, authViewModel: authViewModel);
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
