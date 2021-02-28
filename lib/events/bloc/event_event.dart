import 'package:equatable/equatable.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();
}

class EventInitialize extends EventEvent{

  @override
  List<Object> get props => [];

}


class EventCreate extends EventEvent {
  final Event event;

  const EventCreate(this.event);

  @override
  List<Object> get props => [event];

  @override
  String toString() => 'Event Created {event: $event}';
}


class EventUpdate extends EventEvent {
  final Event event;

  const EventUpdate(this.event);

  @override
  List<Object> get props => [event];

  @override
  String toString() => 'Event Updated {event: $event}';
}


class EventDelete extends EventEvent {
  final Event event;

  const EventDelete(this.event);

  @override
  List<Object> get props => [event];

  @override
  toString() => 'Event Deleted {evente: $event}';
}

