import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikusevents/events/repository/event_repository.dart';
import 'package:tikusevents/registration/repository/register_repository.dart';

import 'app_route.dart';
import 'events/bloc/bloc.dart';
import 'registration/bloc/bloc.dart';

class UserWrapper extends StatelessWidget {

  final RegisterRepository registerRepository;
  final EventRepository eventRepository;

  UserWrapper({this.registerRepository, this.eventRepository});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: this.registerRepository,),
        RepositoryProvider.value(value: this.eventRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => RegisterBloc(registerRepository: this.registerRepository)..add(RegisterInitialize()),
          ),

          BlocProvider(
            create: (BuildContext context) => EventBloc(eventRepository: this.eventRepository)..add(EventInitialize()),
          ),

        ],
        child: MaterialApp(
          title: 'Tikus Events',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: AppRoute.generateRoute,
        ),
      ),
    );
  }
}
