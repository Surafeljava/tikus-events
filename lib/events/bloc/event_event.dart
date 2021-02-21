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
