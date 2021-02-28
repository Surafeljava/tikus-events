import 'package:flutter/material.dart';
import 'package:tikusevents/registration/models/register_model.dart';

class RegisterDetail extends StatelessWidget {

  static final routeName = '/register/detail';

  final RegisterModel registerModel;

  RegisterDetail({this.registerModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Register Details'),
      ),
    );
  }
}
