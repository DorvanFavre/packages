part of '../messenger.dart';

class _PrivateRoomViewModelImpl implements PrivateRoomViewModel {
  _PrivateRoomViewModelImpl({
    @required this.room,
    @required this.authViewModel,
    this.roomOption = const RoomOption(),
  }) {
    inputMessageController = TextEditingController();
    messagesNotifier = ValueNotifier([]);
    _infoBehavior = BehaviorSubject();
    infoStream = _infoBehavior.stream;

    _infoBehavior.add('PrivateRoomViewModel : instancied');

    fetchMoreMessages();

    _incomingMessageSubscription =
        MessengerService()._incomingMessageStream(room).listen((message) {
      if (!_firstStream) {
        messagesNotifier.value.insert(0, message);
        messagesNotifier.notifyListeners();
        _infoBehavior.add(
            'PrivateRoomViewModel : message recieved : ${message?.content ?? '-'}');
      } else {
        _firstStream = false;
      }
    });
  }

  final Room room;
  final RoomOption roomOption;

  @override
  TextEditingController inputMessageController;

  @override
  ValueNotifier<List<Message>> messagesNotifier;

  @override
  Future<Result> fetchMoreMessages() {
    _infoBehavior.add('PrivateRoomViewModel : Fetch more messages');
    if (!_isLoading && !_noMoreMessageToFetch) {
      _isLoading = true;

      return MessengerService()
          ._fetchMessages(
        room,
        roomOption.loadOldMessageAmount,
        _lastDoc,
      )
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
    } else
      _infoBehavior.add(
          'PrivateRoomViewModel :   Already fetching messages or no more messages to fetch');
    return Future.value(Failure(
        message: 'Already fetching messages or no more messages to fetch'));
  }

  @override
  Future<Result> sendMessage() {
    _infoBehavior.add('PrivateRoomViewModel : Send message');
    return authViewModel.authStateStream.first.then((authState) {
      if (authState is UserLoggedIn) {
        final user = authState.user;

        final now = Timestamp.now();

        Message message = Message(
          content: inputMessageController.text,
          contentType: 'text', // Todo change
          senderId: user.uid,
          sentTime: now,
        );

        return MessengerService()._saveMessage(room, message)
          ..then((result) {
            if (result is Success) {
              inputMessageController.clear();
              _infoBehavior.add(
                  'PrivateRoomViewModel :   Success : Message saved to database');
            } else if (result is Failure) {
              _infoBehavior
                  .add('PrivateRoomViewModel :   Failure : ${result.message}');
            }
          });
      } else {
        _infoBehavior.add(
            'PrivateRoomViewModel :   Cannot send message if no user logged in');
        return Future.value(
            Failure(message: 'Cannot send message if no user logged in'));
      }
    });
  }

  // Private

  bool _firstStream = true;
  bool _isLoading = false;
  bool _noMoreMessageToFetch = false;
   _lastDoc;
  StreamSubscription _incomingMessageSubscription;
  BehaviorSubject<String> _infoBehavior;

  @override
  void dispose() {
    _incomingMessageSubscription.cancel();
    inputMessageController.dispose();
    _infoBehavior.close();
  }

  @override
  Stream<String> infoStream;

  @override
  AuthViewModel authViewModel;
}
