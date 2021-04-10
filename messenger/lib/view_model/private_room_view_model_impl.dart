part of '../messenger.dart';

class _PrivateRoomViewModelImpl implements PrivateRoomViewModel {
  _PrivateRoomViewModelImpl(
      {@required this.room,
      @required this.roomOption,
      @required this.authViewModel}) {
    messageController = TextEditingController();
    messagesNotifier = ValueNotifier([]);
    _infoBehavior = BehaviorSubject();
    infoStream = _infoBehavior.stream;

    _infoBehavior.add('PrivateRoomViewModel : instancied');
  }

  final Room room;
  final RoomOption roomOption;

  @override
  TextEditingController messageController;

  @override
  ValueNotifier<List<Message>> messagesNotifier;

  @override
  Future<Result> fetchMoreMessages() {
    _infoBehavior.add('PrivateRoomViewModel : Fetch more messages');
    if (!_isLoading && !_noMoreMessageToFetch) {
      _isLoading = true;
      if (_lastDoc == null) {
        return _MessengerService()
            .fetchMessages(room, roomOption.firstLoadAmount)
            .then((result) {
          if (result is Success<List<Message>>) {
            final newMessages = result.data;
            _infoBehavior.add(
                'PrivateRoomViewModel :   ${newMessages.length} messages fetched');
            newMessages.map((e) =>
                _infoBehavior.add('PrivateRoomViewModel :      ${e.content}'));
            messagesNotifier.value = messagesNotifier.value + newMessages;
            if (newMessages.length < roomOption.firstLoadAmount) {
              _noMoreMessageToFetch = true;
              _infoBehavior
                  .add('PrivateRoomViewModel :   No more message to fetch');
            }
          }
          _isLoading = false;
          return result;
        });
      } else {
        return _MessengerService()
            .fetchMessages(room, roomOption.loadOldMessageAmount,
                fromLastDoc: _lastDoc)
            .then((result) {
          if (result is Success<List<Message>>) {
            final newMessages = result.data;
            _infoBehavior.add(
                'PrivateRoomViewModel :   ${newMessages.length} messages fetched');
            newMessages.map((e) =>
                _infoBehavior.add('PrivateRoomViewModel :      ${e.content}'));
            messagesNotifier.value = messagesNotifier.value + newMessages;
            if (newMessages.length < roomOption.loadOldMessageAmount) {
              _noMoreMessageToFetch = true;
              _infoBehavior
                  .add('PrivateRoomViewModel :   No more message to fetch');
            }
          }
          _isLoading = false;
          return result;
        });
      }
    } else
      _infoBehavior.add(
          'PrivateRoomViewModel :   Already fetching messages or no more messages to fetch');
    return Future.value(Failure(
        message: 'Already fetching messages or no more messages to fetch'));
  }

  @override
  Future<Result> sendMessage() {
    authViewModel.authStateStream.first.then((authState) {
      if (authState is UserLoggedIn) {
        final user = authState.user;

        final sendtTime = Timestamp.now();
        final documentId =
            (10000000000000 - now.millisecondsSinceEpoch).toString();

        final documentReference = widget.documentReference
            .collection(kMessagesCollection)
            .doc(documentId);

        Message message = Message(
          content: messageController.text,
          contentType: 'text', // Todo change
          senderId: user.uid,
          sentTime: sendtTime,
        );
      }
    });
  }

  // Private

  bool _isLoading = false;
  bool _noMoreMessageToFetch = false;
  QueryDocumentSnapshot _lastDoc;
  BehaviorSubject<String> _infoBehavior;

  @override
  void dispose() {
    messageController.dispose();
    _infoBehavior.close();
  }

  @override
  Stream<String> infoStream;

  @override
  AuthViewModel authViewModel;
}
