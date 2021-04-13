part of '../messenger.dart';

class MessageContainerView extends StatelessWidget {
  final Message message;

  MessageContainerView({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 130, 10),
      alignment: Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.only(right: 10),
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
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
