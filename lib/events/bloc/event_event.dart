import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:tikusevents/events/models/my_event_model.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();
}

class EventInitialize extends EventEvent{

  @override
  List<Object> get props => [];

}


class EventCreate extends EventEvent {
  final MyEventModel event;
  final File image;

  const EventCreate(this.event, this.image);

  @override
  List<Object> get props => [event, image];

  @override
  String toString() => 'Event Created {event: $event}';
}


class EventUpdate extends EventEvent {
  final MyEventModel event;

  const EventUpdate(this.event);

  @override
  List<Object> get props => [event];

  @override
  String toString() => 'Event Updated {event: $event}';
}


class EventDelete extends EventEvent {
  final MyEventModel event;

  const EventDelete(this.event);

  @override
  List<Object> get props => [event];

  @override
  toString() => 'Event Deleted {evente: $event}';
}

