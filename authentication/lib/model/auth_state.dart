part of '../authentication.dart';

abstract class AuthState {}

class NoUserLoggedIn extends AuthState {}

class UserLoggedIn extends AuthState {
  UserLoggedIn({@required this.user});

  final User user;
}