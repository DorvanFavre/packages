part of '../messenger.dart';

class PrivateRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ValueListenableBuilder<List<Message>>(
              valueListenable: context.read<RoomViewModel>().messagesNotifier,
              builder: (context, messages, child) => NotificationListener(
                  onNotification: (ScrollNotification scrollNotification) {
                    if (scrollNotification is ScrollEndNotification &&
                        scrollNotification.metrics.extentAfter == 0) {
                      context.read<RoomViewModel>().fetchMoreMessages();
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
                            return MessageContainerView(message: message);
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
    );
  }
}
