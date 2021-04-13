part of '../messenger.dart';

class PrivateRoomView extends StatelessWidget {
  final RoomViewModel viewModel;

  PrivateRoomView({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    // Provide RoomViewModel
    return Provider.value(
      value: viewModel,
      builder: (context, child) {
        return Expanded(
          // Check if user is authenticated
          child: StreamBuilder<AuthState>(
            stream: context.read<RoomViewModel>().authViewModel.authStateStream,
            builder: (context, authStateSnap) {
              if (authStateSnap.connectionState != ConnectionState.active)
                return SizedBox.shrink();
              else {
                final authState = authStateSnap.data;
                if (authState is UserLoggedIn) {
                  // Provide current user
                  /*return Provider<User>.value(
                    value: ,
                                      child: Column(
                      children: [
                        Expanded(
                          child: ValueListenableBuilder<List<Message>>(
                              valueListenable: viewModel.messagesNotifier,
                              builder: (context, messages, child) =>
                                  NotificationListener(
                                      onNotification: (ScrollNotification
                                          scrollNotification) {
                                        if (scrollNotification
                                                is ScrollEndNotification &&
                                            scrollNotification
                                                    .metrics.extentAfter ==
                                                0) {
                                          viewModel.fetchMoreMessages();
                                          return true;
                                        } else
                                          return false;
                                      },
                                      child: messages.length > 0
                                          ? ListView.builder(
                                              reverse: true,
                                              itemCount: messages.length,
                                              itemBuilder: (context, index) {
                                                final message = messages[index];
                                                return MessageContainerView(
                                                    message: message);
                                              })
                                          : Center(
                                              child: Text('No messages'),
                                            ))),
                        ),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: InputMessage(
                              viewModel: context.read<RoomViewModel>(),
                            ))
                      ],
                    ),
                  );*/
                } else {
                  return Center(
                    child: Text('No User Logged In'),
                  );
                }
              }
            },
          ),
        );
      },
    );
  }
}
