part of '../authentication.dart';

/// Auth state wrapper
/// 
/// Show different views according to the auth state
/// 
///  * child : widget when the user is logged in
///  * noUserLoggedIn : widget when no user is logged in (AuthView() by default)
///  * waiting : widget before any state is defined (SizedBox.shrink() by default)
/// 
/// The waiting process last 1 seconde in order to prevent auth state jitter
class AuthStateWrapper extends StatefulWidget {
  /// Auth view model is needed
  final AuthViewModel viewModel;

  /// Widget when no user is logged in. AuthView() by default
  final Widget noUserLoggedIn;

  /// Widget when a user is logged in
  final Widget child;

  /// Widget while loading the auth state. SizedBox.shrink() by default
  final Widget waiting;

  
  AuthStateWrapper(
      {@required this.viewModel,
      @required this.child,
      Widget noUserLoggedIn,
      this.waiting = const SizedBox.shrink()})
      : this.noUserLoggedIn = noUserLoggedIn == null
            ? AuthView(viewModel: viewModel)
            : noUserLoggedIn;

  @override
  _AuthStateWrapperState createState() => _AuthStateWrapperState();
}

class _AuthStateWrapperState extends State<AuthStateWrapper> {
  AuthState _authState = null;
  StreamSubscription authStateSubscription;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1), () {
      authStateSubscription =
          widget.viewModel.authStateStream.listen((authState) {
        setState(() {
          _authState = authState;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _authState == null
        ? widget.waiting
        : _authState is NoUserLoggedIn
            ? widget.noUserLoggedIn
            : widget.child;
  }

  @override
  void dispose() {
    authStateSubscription?.cancel();
    super.dispose();
  }
}
