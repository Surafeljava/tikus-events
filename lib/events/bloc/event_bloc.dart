import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tikusevents/events/bloc/bloc.dart';
import 'package:tikusevents/events/repository/event_repository.dart';

class EventBloc extends Bloc<EventEvent, EventState>{

  final EventRepository eventRepository;

  EventBloc({@required this.eventRepository})
      : assert(eventRepository != null),
        super(EventLoading());

  @override
  Stream<EventState> mapEventToState(EventEvent event) async*{
    if(event is EventInitialize){
      yield EventInitialState();
    }
  }
}