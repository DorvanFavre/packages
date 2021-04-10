part of '../messenger.dart';

/// Private room view model
///
///
abstract class PrivateRoomViewModel {

  factory PrivateRoomViewModel({Room room, RoomOption roomOption}) {
    throw UnimplementedError(
        'PrivateRoomViewModel has no implementation yet'); // TODO
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
  Result fetchMoreMessages();

  /// Send message
  ///
  /// Send the text of the [messageController]
  Result sendMessage();

  /// Message controller
  ///
  /// The text you are about to send
  TextEditingController messageController;

  void dispose();
}
