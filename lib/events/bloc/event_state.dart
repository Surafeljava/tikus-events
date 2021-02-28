import 'package:equatable/equatable.dart';
import 'package:tikusevents/registration/models/event_model.dart';

class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventLoading extends EventState{}

class EventInitialState extends EventState{}


class EventLoadSuccess extends EventState {
  final List<EventModel> events;

  EventLoadSuccess([this.events = const []]);

  @override
  List<Object> get props => [events];
}

class EventOperationFailure extends EventState {}