import 'package:result/result.dart';
import 'package:test/test.dart';

void main() {
  group('Result is', () {
    final String message = "a message";
    Result<int> returnSuccess() {
      return Success(data: 10, message: message);
    }

    Result<int> returnSuccessFromFactory() {
      return Result.success(data: 10, message: message);
    }

    Result<int> returnFailure() {
      return Failure(message: message);
    }

    Result<int> returnFailureFromFactory() {
      return Result.failure(message: message);
    }

    setUp(() {
      // Additional setup goes here.
    });

    test('success', () {
      final result = returnSuccess();

      expect(result is Success, isTrue);
      expect(result is Success<int>, isTrue);

      if (result is Success<int>) {
        expect(result.data, 10);
        expect(result.message, message);
      }
    });

    test('success call function', () {
      final result = returnSuccess();

      expect(result is Success, isTrue);
      expect(result is Success<int>, isTrue);

      if (result is Success<int>) {
        expect(result(), 10);
        expect(result.message, message);
      }
    });

    test('success from factory', () {
      final result = returnSuccessFromFactory();

      expect(result is Success, isTrue);
      expect(result is Success<int>, isTrue);

      if (result is Success<int>) {
        expect(result.data, 10);
        expect(result.message, message);
      }
    });

    test('failure', () {
      final result = returnFailure();

      expect(result is Failure, isTrue);
      expect(result is Failure<int>, isTrue);

      if (result is Failure) {
        expect(result.message, message);
      }
    });

    test('failure from factory', () {
      final result = returnFailureFromFactory();

      expect(result is Failure, isTrue);
      expect(result is Failure<int>, isTrue);

      if (result is Failure) {
        expect(result.message, message);
      }
    });
  });
}
