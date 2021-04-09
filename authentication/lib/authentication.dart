
/// Authentication - see the [GitHub repo](https://github.com/DorvanFavre/authentication)
/// 
/// AuthViewModel()
/// 
///  * login()
///  * logout()
///  * register()
///  * ValueStream<AuthState> authState
/// 
/// AuthStateWrapper(AuthViewModel)
/// 
///  * Show different views according to the current auth state
/// 
/// AuthView(AuthViewModel)
/// 
///  * A default auth screen with login screen and register screen
/// 
/// AuthState()
/// 
///  * UserLoggedIn(UserCredential)
///  * NoUserLoggedIn()
/// 
library authentication;

// imports
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tools/tools.dart';


part 'view_model/auth_view_model.dart';
part 'view_model/auth_view_model_impl.dart';

part 'view/auth_view.dart';
part 'view/auth_state_wrapper_view.dart';

part 'model/auth_state.dart';

part 'service/auth_service.dart';
part 'service/auth_service_firebase.dart';