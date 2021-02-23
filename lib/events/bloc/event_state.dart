import 'package:equatable/equatable.dart';

class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventLoading extends EventState{}

class EventInitialState extends EventState{}


class EventLoadSuccess extends EventState {
  final List<Event> events;

  EventLoadSuccess([this.events = const []]);

  @override
  List<Object> get props => [events];
}
