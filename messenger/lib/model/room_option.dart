part of '../messenger.dart';

class RoomOption {
  /// Number of message loaded when opening the room
  final int firstLoadAmount;

  /// Number of message loaded when call getOldMessages()
  final int loadOldMessageAmount;

  const RoomOption({this.firstLoadAmount = 10, this.loadOldMessageAmount = 5});
}
