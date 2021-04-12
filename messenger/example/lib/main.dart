import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:authentication/authentication.dart' as auth;
import 'package:authentication/authentication.dart';
import 'package:tools/tools.dart';

import 'messenger_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  auth.AuthViewModel authViewModel;
  StreamSubscription sub;

  @override
  void initState() {
    super.initState();

    authViewModel = auth.AuthViewModel();

    sub = authViewModel.authStateStream.listen((event) {
      print(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        auth.AuthStateWrapper(
          viewModel: authViewModel,
          //child: Test(),
          child: MessengerScreen(
            authViewModel: authViewModel,
          ),
          noUserLoggedIn: auth.AuthView(
            viewModel: authViewModel,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    sub?.cancel();
    authViewModel?.dispose();
    super.dispose();
  }
}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: () {
            print('Test');

            /*FirebaseFirestore.instance.collection('Rooms').get().then((value) {
              print('get ' + value.docs.length.toString());
              for (final doc in value.docs) {
                print(doc.id);
              }
            }).catchError((e) => print(e));*/

            FirebaseFirestore.instance
                .collection('Rooms')
                .doc('secondUserIdk8LIxQsA4JdakTmqWX8qtNHQ8Ay2')
                .collection('Messages')
                .get()
                .then((value) => print(value));
          },
          child: Text('Test')),
    );
  }
}
