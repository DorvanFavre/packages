part of 'tools.dart';

/// Result
/// 
/// Result is an abstract class, can be either Success() or Failure()
abstract class Result<S> {}

class Success<T> extends Result<T> {
  Success({this.data});
  T data;
}

class Failure extends Result {
  final String message;

  Failure({this.message = 'no message'});
}
