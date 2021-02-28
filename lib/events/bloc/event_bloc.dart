import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tikusevents/events/bloc/bloc.dart';
import 'package:tikusevents/events/models/my_event_model.dart';
import 'package:tikusevents/events/repository/event_repository.dart';

class EventBloc extends Bloc<EventEvent, EventState>{

  final EventRepository eventRepository;

  EventBloc({@required this.eventRepository})
      : assert(eventRepository != null),
        super(EventLoading());

  @override
  Stream<EventState> mapEventToState(EventEvent event) async*{
    if (event is EventInitialize) {
      yield EventLoading();
      try {
        List<dynamic> result = await eventRepository.getAllEvents();
        if(result[0]){
          List<MyEventModel> myEvents = result[1];
          yield EventInitialized(events: myEvents);
        }else{
          yield EventOperationFailure();
        }
      } catch (_) {
        yield EventOperationFailure();
      }
    }

    if (event is EventCreate) {
      yield EventLoading();
      try {
        List<dynamic> result = await eventRepository.createEvent(event.event, event.image);
        if(result[0]){
          yield EventCreateSuccess();
        }else{
          yield EventOperationFailure(failedMessage: result[1]);
        }
      } catch (_) {
        yield EventOperationFailure();
      }
    }

    if (event is EventUpdate) {
      yield EventLoading();
      try {
        List<dynamic> result = await eventRepository.updateEvent(event.event);
        if(result[0]){
          yield EventUpdateSuccess();
        }else{
          yield EventOperationFailure(failedMessage: result[1]);
        }
      } catch (_) {
        yield EventOperationFailure();
      }
    }

    if (event is EventDelete) {
      yield EventLoading();
      try {
        List<dynamic> result = await eventRepository.deleteEvent(event.event);
        if(result[0]){
          yield EventDeleteSuccess();
        }else{
          yield EventOperationFailure(failedMessage: result[1]);
        }
      } catch (_) {
        yield EventOperationFailure();
      }
    }
  }
}