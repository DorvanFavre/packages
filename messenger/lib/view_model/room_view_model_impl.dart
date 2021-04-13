part of '../messenger.dart';

class _RoomViewModelImpl implements RoomViewModel {
  _RoomViewModelImpl({
    @required this.authViewModel,
    @required this.room,
    this.roomOption = const RoomOption(),
  }) {
    inputMessageController = TextEditingController();
    messagesNotifier = ValueNotifier([]);
    _infoBehavior = BehaviorSubject();
    infoStream = _infoBehavior.stream;

    _infoBehavior.add('RoomViewModel : instancied');

    // Load messages
    fetchMoreMessages();

    // Subscribe to the incoming messages
    _incomingMessageSubscription =
        _MessengerService()._incomingMessageStream(room).listen((message) {
      if (!_firstStream) {
        messagesNotifier.value.insert(0, message);
        messagesNotifier.notifyListeners();
        _infoBehavior.add(
            'RoomViewModel : message recieved : ${message?.content ?? '-'}');
      } else {
        _firstStream = false;
      }
    });
  }

  final AuthViewModel authViewModel;
  final Room room;
  final RoomOption roomOption;

  @override
  TextEditingController inputMessageController;

  @override
  ValueNotifier<List<Message>> messagesNotifier;

  @override
  Future<Result> fetchMoreMessages() {
    _infoBehavior.add('RoomViewModel : Fetch more messages');
    if (!_isLoading && !_noMoreMessageToFetch) {
      _isLoading = true;

      return _MessengerService()
          ._fetchMessages(
        room,
        _lastDoc.value == null
            ? roomOption.firstLoadAmount
            : roomOption.loadOldMessageAmount,
        _lastDoc,
      )
          .then((result) {
        if (result is Success<List<Message>>) {
          final newMessages = result.data;
          _infoBehavior
              .add('RoomViewModel :   ${newMessages.length} messages fetched');
          newMessages.map(
              (e) => _infoBehavior.add('RoomViewModel :      ${e.content}'));
          messagesNotifier.value = messagesNotifier.value + newMessages;
          if (newMessages.length < roomOption.loadOldMessageAmount) {
            _noMoreMessageToFetch = true;
            _infoBehavior.add('RoomViewModel :   No more message to fetch');
          }
        }
        _isLoading = false;
        return result;
      }).catchError((e) {
        _infoBehavior.add('RoomViewModel :   Error : ${e.toString()}');
        return Failure<List<Message>>(message: e.toString());
      });
    } else
      _infoBehavior.add(
          'RoomViewModel :   Already fetching messages or no more messages to fetch');
    return Future.value(Failure(
        message: 'Already fetching messages or no more messages to fetch'));
  }

  @override
  Future<Result> sendMessage() {
    _infoBehavior.add('RoomViewModel : Send message');
    return authViewModel.authStateStream.first.then((authState) {
      if (authState is UserLoggedIn) {
        final userId = authState.userId;

        final now = Timestamp.now();

        Message message = Message(
          content: inputMessageController.text,
          contentType: 'text', // Todo change
          senderId: userId,
          sentTime: now,
        );

        return _MessengerService()._saveMessage(room, message)
          ..then((result) {
            if (result is Success) {
              inputMessageController.clear();
              _infoBehavior
                  .add('RoomViewModel :   Success : Message saved to database');
            } else if (result is Failure) {
              _infoBehavior
                  .add('RoomViewModel :   Failure : ${result.message}');
            }
          });
      } else {
        _infoBehavior
            .add('RoomViewModel :   Cannot send message if no user logged in');
        return Future.value(
            Failure(message: 'Cannot send message if no user logged in'));
      }
    });
  }

  // Private

  bool _firstStream = true;
  bool _isLoading = false;
  bool _noMoreMessageToFetch = false;
  PrimitiveWrapper<QueryDocumentSnapshot> _lastDoc = PrimitiveWrapper(null);
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
}
