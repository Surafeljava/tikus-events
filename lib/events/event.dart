import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikusevents/events/bloc/bloc.dart';
import 'package:tikusevents/events/repository/event_repository.dart';
import 'package:tikusevents/events/screens/event_routes.dart';

class Event extends StatelessWidget{

  static final routeName = "/event/page";

  final EventRepository eventRepository;

  Event({@required this.eventRepository}) : assert(eventRepository != null);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: RepositoryProvider.value(
          value: this.eventRepository,
          child: BlocProvider(
            create: (context) => EventBloc(eventRepository: this.eventRepository)..add(EventInitialize()),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.orange,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              onGenerateRoute: EventRoutes.generateRoute,
            ),
          ),
        )
    );
  }
}
