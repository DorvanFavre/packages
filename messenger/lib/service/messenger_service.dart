part of '../messenger.dart';

abstract class _MessengerService{

  factory _MessengerService() {
    throw UnimplementedError(
        'has no implementation yet'); // TODO
  }

  Result fetchMessages();

  Stream<Message> incomingMessageStream(Room room);
  


  
}