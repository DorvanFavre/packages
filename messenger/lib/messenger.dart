/// # Messenger 
/// see the [GitHub repo](https://github.com/DorvanFavre/packages/tree/main/messenger)
///
///
/// ## Main features
/// 
/// Implement a messenger API in your project
///  * Private conversations
///
/// ## Getting started
/// 
/// Open a room : _RoomViewModel.openRoom(firstUserId, secondUserId)_
///
/// Instenciate a roomViewModel : RoomViewModel(authViewModel, room)
/// 
/// Use the Room widget : PrivateRoomView(roomViewModel)
/// 
/// ## Classes
/// 
/// ### View
///  * PrivateRoomView
///  * InputMessageView
///  * MessageView
///
/// ### Model
///
///  * Room
///  * RoomOption
///  * Message
///
/// ### ViewModel
///  * RoomViewModel
///
/// 
///
///
///
library messenger;

import 'dart:async';

import 'package:authentication/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tools/tools.dart';

import 'package:flutter/cupertino.dart';

part 'model/message.dart';
part 'model/room_option.dart';
part 'model/room.dart';

part 'view/room_material.dart';
part 'view/private_room.dart';
part 'view/message_container_view.dart';
part 'view/input_message_view.dart';

part 'view_model/room_view_model.dart';
part 'view_model/room_view_model_impl.dart';

part 'service/messenger_service.dart';
part 'service/messenger_service_firebase.dart';
