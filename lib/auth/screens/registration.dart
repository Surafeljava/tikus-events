import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: TextButton(
          child: Text('Back From Registration!'),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
