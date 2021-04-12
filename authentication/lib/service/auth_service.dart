part of '../authentication.dart';

abstract class _AuthService {
  factory _AuthService() {
    return _AuthServiceFirebase();
  }

  /// Auth state stream
  /// 
  /// Stream of the current authentication state
  Stream<AuthState> authStateStream();

  /// Login
  ///
  /// Login user with email and password
  Future<Result> login(String email, String password);

  /// Logout
  /// 
  /// Logout the user
  Future<void> logout();

  /// Register
  ///
  /// Register new user with email ad password
  Future<Result> register(String email, String password);
}
