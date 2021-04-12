part of '../authentication.dart';

class _AuthServiceFirebase implements _AuthService {
  @override
  Stream<AuthState> authStateStream() {
    return FirebaseAuth.instance
        .authStateChanges()
        .map((event) =>
            event == null ? NoUserLoggedIn() : UserLoggedIn(user: event))
        .shareValue();
  }

  @override
  Future<Result> login(String email, String password) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => Success(data: value) as Result)
        .catchError((e) => Failure(message: e.toString()));
  }

  @override
  Future<Result> register(String email, String password) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => Success(data: value) as Result)
        .catchError((e) => Failure(message: e.toString()));
  }

  @override
  Future<void> logout() {
    return FirebaseAuth.instance.signOut();
  }
}
