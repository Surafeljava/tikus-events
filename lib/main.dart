import 'package:flutter/material.dart';
import 'package:tikusevents/auth/repository/auth_repository.dart';
import 'wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final AuthRepository authRepo = new AuthRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tikus Events',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Wrapper(authRepository: authRepo,),
    );
  }
}

