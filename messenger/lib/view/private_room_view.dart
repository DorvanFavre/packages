part of '../messenger.dart';

class PrivateRoomView extends StatelessWidget {
  final PrivateRoomViewModel viewModel;

  PrivateRoomView({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ValueListenableBuilder<List<Message>>(
              valueListenable: viewModel.messagesNotifier,
              builder: (context, messages, child) => NotificationListener(
                  onNotification: (ScrollNotification scrollNotification) {
                    if (scrollNotification is ScrollEndNotification &&
                        scrollNotification.metrics.extentAfter == 0) {
                      viewModel.fetchMoreMessages();
                      return true;
                    } else
                      return false;
                  },
                  child: messages.length > 0
                      ? ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            return MessageView(message: message);
                          })
                      : ListView(
                          children: [
                            Center(
                              child: Text('No messages'),
                            ),
                          ],
                        ))),
        ),
        Padding(
            padding: EdgeInsets.all(20),
            child: InputMessage(
              viewModel: viewModel,
            ))
      ],
    );
  }
}