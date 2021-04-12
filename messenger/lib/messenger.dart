/// Messenger - see the [GitHub repo](https://github.com/DorvanFavre/packages/tree/main/messenger)
///
/// Implement a messenger API in your project
///  * Private conversations
///
///
/// RoomViewModel
///  * Future<Result<Room>> openPrivateRoom(String, String)
///
///
/// RoomViewModel(AuthViewModel, Room, RoomOption)
///  * messageNotifier
///  * inputMessageController
///  * fetchMoreMessages()
///  * sendMessage()
///  * infoStream
///  * dispose()
///
///
///
///
library messenger;

import 'dart:async';

import 'package:authentication/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tools/tools.dart';

import 'package:flutter/cupertino.dart';

part 'model/message.dart';
part 'model/room_option.dart';
part 'model/room.dart';

part 'view/private_room_view.dart';
part 'view/message_view.dart';
part 'view/input_message_view.dart';

part 'view_model/room_view_model.dart';
part 'view_model/room_view_model_impl.dart';

part 'service/messenger_service.dart';
part 'service/messenger_service_firebase.dart';
