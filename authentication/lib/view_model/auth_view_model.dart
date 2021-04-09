part of '../authentication.dart';

/// Auth view model
///
/// Provide the neccessary material for authentication
///
/// /!\ Be sure to have Firebase Auth and  'login with email and password' enable in your Firebase console
///
/// /!\ Be sure to have Firebase Firestore enable in your Firebase console and set the rules
///
/// /!\ Don't forget to import the SDKs and initialize firebase in your index.html
///
/// /!\ Don't forget to run '$ firebase init' and enable Auth and Firestore
abstract class AuthViewModel {
  
  factory AuthViewModel() {
    return _AuthViewModelImpl();
  }

  // Public

  /// Auth state stream
  ///
  /// Stream of the current user state
  ValueStream<AuthState> authStateStream;

  TextEditingController emailLoginController;
  TextEditingController passwordLoginController;

  TextEditingController emailRegisterController;
  TextEditingController passwordRegisterController;
  TextEditingController repeatePasswordRegisterController;

  /// Login
  ///
  /// Login the user according with the email and password
  Future<Result> login();

  /// Register
  ///
  /// Register a new user with email and password
  Future<Result> register();

  void dispose();
}
