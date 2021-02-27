import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc.dart';
import 'screens/event_screens.dart';

class Event extends StatefulWidget {
  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<EventBloc, EventState>(
        builder: (context, state){
          if(state is EventInitialState){
            return EventList();
          }

          else{
            return EventList();
          }
        },
      ),
    );
  }
}
