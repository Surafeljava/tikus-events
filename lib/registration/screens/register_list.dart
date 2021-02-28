import 'package:flutter/material.dart';

class RegisterList extends StatefulWidget {

  static final routeName = '/register/register_list';

  @override
  _RegisterListState createState() => _RegisterListState();
}

class _RegisterListState extends State<RegisterList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Register List"),
      ),
    );
  }
}
