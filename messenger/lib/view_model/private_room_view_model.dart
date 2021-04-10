part of '../messenger.dart';

/// Private room view model
///
///
abstract class PrivateRoomViewModel {
  factory PrivateRoomViewModel(
      {Room room, RoomOption roomOption, AuthViewModel authViewModel}) {
    return _PrivateRoomViewModelImpl(
        room: room, roomOption: roomOption, authViewModel: authViewModel);
  }

  static Future<Result<Room>> createPrivateRoom(AuthViewModel authViewModel, String withUserId){
    return authViewModel.authStateStream.first.then((authState) {
      if(authState is UserLoggedIn){
        final user = authState.user;

        return _MessengerService().createPrivateRoom(); // TODO 
      }
      else{
        return Future.value(Failure(message: 'Cannot create room if no user logged in'));
      }
    })
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
  /// Send the text of the [messageController]
  Future<Result> sendMessage();

  /// Message controller
  ///
  /// The text you are about to send
  TextEditingController messageController;

  /// Stream of messages to help debugging
  Stream<String> infoStream;

  AuthViewModel authViewModel;

  void dispose();
}
