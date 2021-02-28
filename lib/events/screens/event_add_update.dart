
import 'package:flutter/material.dart';
import 'package:tikusevents/registration/models/register_argument.dart';

class UpdateEvent extends StatefulWidget {
  static const routeName = 'updateEvent';
  final RegisterArgument args;

  UpdateEvent({this.args});
  @override
  _AddUpdateEventState createState() => _AddUpdateEventState();
}

class _AddUpdateEventState extends State<UpdateEvent> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _event = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.args.edit ? "Edit Event" : "Add New Event"}'),
      ),
      body: Container(),
    );
  }
}
