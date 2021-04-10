part of '../messenger.dart';

class PrivateRoomViewModelImpl implements PrivateRoomViewModel {


  PrivateRoomViewModelImpl(){
     messageController = TextEditingController();
     messagesNotifier = ValueNotifier([]);
  }

  @override
  TextEditingController messageController;

  @override
  ValueNotifier<List<Message>> messagesNotifier;


  @override
  Result fetchMoreMessages() {
    if(!_isLoading && !_noMoreMessageToFetch){
      _isLoading = true;
      if(_lastDoc == null){

      }
    }
  }

  @override
  Result sendMessage() {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }


  // Private
  
  bool _isLoading = false;
  bool _noMoreMessageToFetch = false;
  QueryDocumentSnapshot _lastDoc;

  @override
  void dispose() {
    messageController.dispose();
  }

  
}
