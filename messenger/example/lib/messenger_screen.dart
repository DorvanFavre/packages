import 'dart:async';

import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:messenger/messenger.dart' as mes;
import 'package:messenger/messenger.dart';
import 'package:tools/tools.dart';

class MessengerScreen extends StatefulWidget {
  final AuthViewModel authViewModel;

  MessengerScreen({@required this.authViewModel});

  @override
  _MessengerScreenState createState() => _MessengerScreenState();
}

class _MessengerScreenState extends State<MessengerScreen> {
  mes.PrivateRoomViewModel privateRoomViewModel;
  StreamSubscription infoSubscription;

  @override
  void initState() {
    super.initState();

    initialize();
  }

  void initialize() async {
    final authState = await widget.authViewModel.authStateStream.first;
    if (authState is UserLoggedIn) {
      final firstUserId = authState.user.uid;

      final roomResult = await (mes.PrivateRoomViewModel
          .openPrivateRoom(firstUserId, 'secondUserId')
            ..then((value) => print('Room opened successfuly'))
            ..catchError((e) => print('Error : ' + e.toString())));
      if (roomResult is Success<mes.Room>) {
        final room = roomResult.data;

        setState(() {
          privateRoomViewModel = mes.PrivateRoomViewModel(
              authViewModel: widget.authViewModel,
              room: room,
              roomOption:
                  mes.RoomOption(firstLoadAmount: 10, loadOldMessageAmount: 5));
        });

        infoSubscription = privateRoomViewModel.infoStream.listen((event) {
          print(event);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        privateRoomViewModel != null
            ? mes.PrivateRoomView(
                viewModel: privateRoomViewModel,
              )
            : Center(
                child: Text('Loading...'),
              ),

        // Logout button
        TextButton(
            onPressed: () {
              widget.authViewModel.logout();
            },
            child: Text('Logout'))
      ],
    ));
  }

  @override
  void dispose() {
    print('Messenger screen : Dispose');
    infoSubscription?.cancel();
    privateRoomViewModel?.dispose();
    super.dispose();
  }
}
