part of '../authentication.dart';

// Implementation
class _AuthViewModelImpl implements AuthViewModel {
  _AuthViewModelImpl() {
    emailLoginController = TextEditingController();
    passwordLoginController = TextEditingController();
    emailRegisterController = TextEditingController();
    passwordRegisterController = TextEditingController();
    repeatePasswordRegisterController = TextEditingController();

    authStateStream = _AuthService().authStateStream();
  }

  @override
  ValueStream<AuthState> authStateStream;

  @override
  TextEditingController emailLoginController;

  @override
  TextEditingController emailRegisterController;

  @override
  TextEditingController passwordLoginController;

  @override
  TextEditingController passwordRegisterController;

  @override
  TextEditingController repeatePasswordRegisterController;

  @override
  Future<Result> login() {
    final email = emailLoginController.text;
    final password = passwordLoginController.text;

    String message = null;
    if (email.trim().isEmpty) {
      message = 'Enter a email please';
    } else if (!email.contains('@')) {
      message = 'Enter a valide email please';
    } else if (password.trim().isEmpty) {
      message = 'Enter a password please';
    }

    if (message != null) {
      return Future.value(Failure(message: message));
    }

    return _AuthService().login(email, password);
  }

  @override
  Future<Result> register() {
    final email = emailRegisterController.text;
    final password = passwordRegisterController.text;
    final repeatePassword = repeatePasswordRegisterController.text;

    String message = null;
    if (email.trim().isEmpty) {
      message = 'Enter a email please';
    } else if (!email.contains('@')) {
      message = 'Enter a valide email please';
    } else if (password.contains(' ')) {
      message = 'password cannot contain spaces';
    } else if (password.length < 6) {
      message = 'password should be at least 6 character long';
    } else if (password != repeatePassword) {
      message = 'password does not correspond';
    }

    if (message != null) {
      return Future.value(Failure(message: message));
    }

    return _AuthService().register(email, password);
  }

  @override
  void dispose() {
    emailLoginController.dispose();
    passwordLoginController.dispose();
    emailRegisterController.dispose();
    passwordRegisterController.dispose();
    repeatePasswordRegisterController.dispose();
  }

  @override
  Future<void> logout() {
    return _AuthService().logout();
  }
}
