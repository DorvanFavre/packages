part of '../messenger.dart';

class MessageContainerView extends StatelessWidget {
  final Message message;

  MessageContainerView({@required this.message});

  @override
  Widget build(BuildContext context) {
    final bool isMyMessage = context.read<String>() == message.senderId;

    return Container(
      padding: isMyMessage
          ? EdgeInsets.fromLTRB(130, 0, 10, 10)
          : EdgeInsets.fromLTRB(10, 0, 130, 10),
      alignment: isMyMessage ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 4,
                  offset: Offset(2, 2))
            ],
            color: Colors.grey,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight:
                  isMyMessage ? Radius.circular(0) : Radius.circular(10),
              topRight: Radius.circular(10),
              topLeft: isMyMessage ? Radius.circular(10) : Radius.circular(0),
            )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment:
                isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              // Username

              Text(
                message?.senderId ?? '-',
                style: TextStyle(color: Theme.of(context).accentColor),
              ),

              // message
              Text(message?.content ?? '-'),
            ],
          ),
        ),
      ),
    );
  }
}
