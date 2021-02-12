import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tikus Events', style: TextStyle(color: Colors.grey[800], letterSpacing: 1.0),),
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey[800]),
      ),
      body: Center(
        child: Text('Tikus Events!'),
      ),
    );
  }
}
