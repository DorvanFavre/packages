import 'package:flutter/material.dart';
import 'package:authentication/authentication.dart' as auth;

void main() {
  auth.AuthViewModel authViewModel = auth.AuthViewModel();

  runApp(MyApp(
    authViewModel: authViewModel,
  ));
}

class MyApp extends StatelessWidget {
  auth.AuthViewModel authViewModel;

  MyApp({@required this.authViewModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: auth.AuthStateWrapper(
        viewModel: authViewModel,
        child: Center(
          child: TextButton(
            child: Text('Logout'),
            onPressed: () {
              authViewModel.logout();
            },
          ),
        ),
      )),
    );
  }
}
