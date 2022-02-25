/// Result
///
/// Result is an abstract class, can be either Success() or Failure()
abstract class Result<T> {
  factory Result.success({required T data, String message = 'no message'}) {
    return Success(data: data, message: message);
  }
  factory Result.failure({String message = 'no message'}) {
    return Failure(message: message);
  }
  Result({required this.message});
  final String message;
}

class Success<T> extends Result<T> {
  final T data;

  Success({required this.data, String message = 'no message'})
      : super(message: message);
}

class Failure<T> extends Result<T> {
  Failure({String message = 'no message'}) : super(message: message);
}
