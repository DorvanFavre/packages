part of '../messenger.dart';

class InputMessage extends StatelessWidget {
  final PrivateRoomViewModel viewModel;

  InputMessage({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    // Input message
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onEditingComplete: () {
                viewModel.sendMessage();
              },
              controller: viewModel.inputMessageController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), fillColor: Colors.white30),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
              onPressed: () {
                viewModel.sendMessage();
              },
              icon: Icon(Icons.send))
        ],
      ),
    );
  }
}
